use std::collections::HashMap;
use std::collections::VecDeque;
use std::env;
use std::fs;

mod common;
use common::*;
use PulseLevel::Low;

fn pulse<'a>(
    modules: &mut HashMap<&'a str, Module<'a>>,
    report: &mut HashMap<&'a str, Option<u64>>,
    round: u64,
) {
    let mut pulses = VecDeque::from([Pulse {
        source: "",
        target: "broadcaster",
        level: Low,
    }]);

    while let Some(Pulse { source, level, .. }) = pulses.front() {
        if *level == PulseLevel::Low {
            report.entry(source).and_modify(|ref mut success_round| {
                success_round.get_or_insert(round);
            });
        }
        send_pulse(modules, &mut pulses);
    }
}

fn find_components<'a>(modules: &HashMap<&'a str, Module<'a>>) -> Option<Vec<Vec<&'a str>>> {
    let mut result = Vec::new();
    let mut frontier = modules.get("broadcaster")?.children.clone();
    let direct_children = frontier.clone();

    while let Some(current) = frontier.pop() {
        if direct_children.iter().any(|e| *e == current) {
            result.push(Vec::new());
        }

        let current_component = result.last_mut()?;

        if current_component.iter().any(|e| *e == current) {
            continue;
        }

        current_component.push(current);

        modules.get(current).map(|module| match module {
            Module {
                children,
                state: ModuleState::FlipFlop { .. },
                ..
            } => frontier.extend(children),
            _ => (),
        });
    }

    return Some(result);
}

fn compute_end<'a>(modules: &HashMap<&'a str, Module<'a>>, component: &Vec<&'a str>) -> &'a str {
    component
        .iter()
        .filter_map(|name| {
            modules.get(name).and_then(|module| match module {
                Module {
                    name,
                    state: ModuleState::Conjunction { .. },
                    ..
                } => Some(*name),
                _ => None,
            })
        })
        .next()
        .unwrap()
}

fn is_done<'a>(infos: &HashMap<&'a str, Option<u64>>) -> bool {
    infos.values().all(|op| op.is_some())
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

    let mut infos: HashMap<_, _> = find_components(&modules)
        .ok_or("The input does not contain components as expected.")?
        .into_iter()
        .map(|c| (compute_end(&modules, &c), None))
        .collect();

    (1..)
        .skip_while(|round| {
            pulse(&mut modules, &mut infos, *round);
            !is_done(&infos)
        })
        .next();

    let result: u64 = infos.values().filter_map(|info| *info).product();

    println!("{}", result);

    Ok(())
}
