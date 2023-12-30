use std::collections::HashMap;
use std::collections::VecDeque;
use std::hash::Hash;

#[derive(Debug, PartialEq, Clone, Copy, Hash)]
pub enum PulseLevel {
    Low,
    High,
}

use self::PulseLevel::*;

pub fn flip(level: PulseLevel) -> PulseLevel {
    match level {
        Low => High,
        High => Low,
    }
}

#[derive(Debug)]
pub enum ModuleState<'a> {
    FlipFlop {
        level: PulseLevel,
    },
    Conjunction {
        inputs: HashMap<&'a str, PulseLevel>,
    },
    Stateless,
}

#[derive(Debug)]
pub struct Module<'a> {
    pub name: &'a str,
    pub children: Vec<&'a str>,
    pub state: ModuleState<'a>,
}
#[derive(Debug)]
pub struct Pulse<'a> {
    pub source: &'a str,
    pub target: &'a str,
    pub level: PulseLevel,
}

pub fn extract_state<'a>(name: &'a str) -> Option<ModuleState<'a>> {
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

pub fn parse_line<'a>(line: &'a str) -> Option<Module<'a>> {
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

pub fn initialize<'a>(modules: &mut HashMap<&'a str, Module<'a>>) {
    let mut parents = HashMap::new();
    for (key, module) in modules.iter() {
        for child in &module.children {
            parents
                .entry(*child)
                .and_modify(|v: &mut Vec<&str>| v.push(key))
                .or_insert(vec![*key]);
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

pub fn send_pulse<'a>(modules: &mut HashMap<&'a str, Module<'a>>, queue: &mut VecDeque<Pulse<'a>>) {
    let Pulse {
        source,
        target,
        level: incoming_level,
    } = queue.pop_front().unwrap();

    modules.entry(target).and_modify(|target_module| {
        compute_pulse(target_module, incoming_level, source).map(|level| {
            queue.extend(target_module.children.iter().map(|child| Pulse {
                source: target_module.name,
                target: child,
                level: level,
            }))
        });
    });
}

pub fn compute_pulse<'a>(
    target_module: &mut Module<'a>,
    incoming_level: PulseLevel,
    source: &'a str,
) -> Option<PulseLevel> {
    match &mut target_module.state {
        ModuleState::Conjunction { inputs } => {
            inputs
                .entry(source)
                .and_modify(|input| *input = incoming_level);
            Some(if inputs.values().all(|level| *level == PulseLevel::High) {
                PulseLevel::Low
            } else {
                PulseLevel::High
            })
        }
        ModuleState::FlipFlop { level } => {
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
