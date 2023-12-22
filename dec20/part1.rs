use std::collections::HashMap;
use std::collections::VecDeque;
use std::env;
use std::fs;

#[derive(Debug, PartialEq, Clone, Copy)]
enum PulseLevel {
    Low,
    High,
}

use PulseLevel::*;

fn flip(level: PulseLevel) -> PulseLevel {
    match level {
        Low => High,
        High => Low,
    }
}

#[derive(Debug)]
enum ModuleState<'a> {
    FlipFlop {
        level: PulseLevel,
    },
    Conjunction {
        inputs: HashMap<&'a str, PulseLevel>,
    },
    Stateless,
}

#[derive(Debug)]
struct Module<'a> {
    name: &'a str,
    children: Vec<&'a str>,
    state: ModuleState<'a>,
}
#[derive(Debug)]
struct Pulse<'a> {
    source: &'a str,
    target: &'a str,
    level: PulseLevel,
}

fn extract_state<'a>(name: &'a str) -> Option<ModuleState<'a>> {
    Some(match name.get(..1)? {
        "%" => ModuleState::FlipFlop {
            level: PulseLevel::Low,
        },
        "&" => ModuleState::Conjunction {
            inputs: HashMap::new(),
        },
        _ => ModuleState::Stateless,
    })
}

fn parse_line<'a>(line: &'a str) -> Option<Module<'a>> {
    let mut parts = line.split_whitespace();
    let name_part = parts.next()?;
    let state = extract_state(name_part)?;
    let name = match state {
        ModuleState::Stateless => name_part,
        _ => name_part.get(1..)?,
    };

    // Skip arrow
    parts.next();

    let children = parts.map(|child| child.trim_end_matches(",")).collect();
    Some(Module {
        name: name,
        children: children,
        state: state,
    })
}

fn initialize<'a>(modules: &mut HashMap<&'a str, Module<'a>>) {
    let mut parents = HashMap::new();
    for (key, module) in modules.iter() {
        for child in &module.children {
            parents
                .entry(child.clone())
                .and_modify(|v: &mut Vec<&str>| v.push(key))
                .or_insert(vec![key.clone()]);
        }
    }

    for (younger, elder) in parents {
        modules.entry(younger).and_modify(|module: &mut Module| {
            if let ModuleState::Conjunction { ref mut inputs } = &mut module.state {
                elder.into_iter().for_each(|p| {
                    inputs.insert(p, PulseLevel::Low);
                })
            }
        });
    }
}

fn send_pulse<'a>(modules: &mut HashMap<&'a str, Module<'a>>, queue: &mut VecDeque<Pulse<'a>>) {
    let Pulse {
        source,
        target,
        level: incoming_level,
    } = queue.pop_front().unwrap();

    modules.entry(target).and_modify(|target_module| {
        let pulse = compute_pulse(target_module, incoming_level, source);

        match pulse {
            Some(level) => {
                queue.extend(target_module.children.iter().map(|child| Pulse {
                    source: (target_module.name),
                    target: child,
                    level: level,
                }));
            }
            None => (),
        };
    });
}



fn compute_pulse<'a>(
    target_module: &mut Module<'a>,
    incoming_level: PulseLevel,
    source: &'a str,
) -> Option<PulseLevel> {
    match target_module {
        Module {
            name: _,
            children: _,
            state: ModuleState::Conjunction { inputs },
        } => {
            inputs
                .entry(source)
                .and_modify(|input| *input = incoming_level);
            Some(if inputs.values().all(|level| *level == PulseLevel::High) {
                PulseLevel::Low
            } else {
                PulseLevel::High
            })
        }
        Module {
            name: _,
            children: _,
            state: ModuleState::FlipFlop { level },
        } => {
            if incoming_level == Low {
                *level = flip(*level);
                Some(*level)
            } else {
                None
            }
        }
        _ => Some(incoming_level),
    }
}

fn pulse<'a> (modules: &mut HashMap<&'a str, Module<'a>>) -> (i64, i64){
    let mut pulses= VecDeque::from([Pulse{source: "", target: "broadcaster", level: Low}]);

    let mut low_pulses_sent = 0;
    let mut high_pulses_sent = 0;

    while !pulses.is_empty()  {
        match pulses.front() {
            Some(Pulse{source, target, level: Low}) => low_pulses_sent += 1,
            Some(Pulse{source, target, level: High}) => high_pulses_sent += 1,
            _ => todo!()
        }
        send_pulse(modules, &mut pulses);

    }
    (low_pulses_sent, high_pulses_sent)
}

fn main() -> Result<(), &'static str> {
    let input = env::args()
        .nth(1)
        .ok_or("Should provide input file as first argument")?;

    let contents = fs::read_to_string(input).or(Err("Should be able to open input file."))?;
    let mut modules: HashMap<&'_ str, Module<'_>> = contents
        .lines()
        .filter_map(parse_line)
        .map(|module| (module.name, module))
        .collect();

    initialize(&mut modules);

    modules.iter().for_each(|module| println!("{:?}", module));

    let mut sum_high = 0;
    let mut sum_low = 0;

    for i in 0..1000 {
        let (low, high) = pulse(&mut modules);
        sum_high += high;
        sum_low += low;
    }

    println!("{}", sum_high*sum_low);
    Ok(())
}
