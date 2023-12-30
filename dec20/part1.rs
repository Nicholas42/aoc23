use std::collections::HashMap;
use std::collections::VecDeque;
use std::env;
use std::fs;

mod common;
use common::*;
use PulseLevel::{High, Low};

fn pulse<'a>(modules: &mut HashMap<&'a str, Module<'a>>) -> (i64, i64) {
    let mut pulses = VecDeque::from([Pulse {
        source: "",
        target: "broadcaster",
        level: Low,
    }]);

    let mut low_pulses_sent = 0;
    let mut high_pulses_sent = 0;

    while let Some(pulse) = pulses.front() {
        match pulse.level {
            Low => low_pulses_sent += 1,
            High => high_pulses_sent += 1,
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

    let (sum_low, sum_high) = (0..1000).fold((0,0), |(sum_low, sum_high), _| {
        let (low, high) = pulse(&mut modules);
        (sum_low + low, sum_high + high)
    });

    println!("{}", sum_high * sum_low);
    Ok(())
}
