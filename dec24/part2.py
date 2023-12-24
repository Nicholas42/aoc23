#!/bin/env python3
import re
import sys
from dataclasses import dataclass
from itertools import islice
from pathlib import Path

from sympy import Eq, Matrix, Symbol, solve, symbols


@dataclass
class Hailstone:
    pos: Matrix
    vel: Matrix

    def tpos(self, t: Symbol | float) -> Matrix:
        return self.pos + t * self.vel


def readInput(fname: Path) -> list[Hailstone]:
    numberRegex = re.compile(r"-?\d+")
    result = []
    with open(fname) as f:
        for line in islice(f, 3):
            [x, y, z, vx, vy, vz] = [[v] for v in map(int, numberRegex.findall(line))]
            result.append(Hailstone(Matrix([x, y, z]), Matrix([vx, vy, vz])))

    return result


def findLine(base: Hailstone, support: Hailstone, target: Hailstone):
    t1, t2, t3, mu = symbols("t1 t2 t3 mu")

    def linCom(lhs, rhs):
        return (1 - mu) * lhs + mu * rhs

    lineEquation = linCom(base.tpos(t1), support.tpos(t2))
    expr = Eq(lineEquation, target.tpos(t3))
    secondary = Eq(linCom(t1, t2), t3)
    [(rt1, rt2, _, _)] = solve([expr, secondary], [t1, t2, t3, mu])
    [mu0] = solve(linCom(rt1, rt2), [mu])

    return sum(lineEquation.subs({t1: rt1, t2: rt2, mu: mu0}))


def main(inputPath: Path):
    stones = readInput(inputPath)
    print(findLine(*stones))


if __name__ == "__main__":
    main(Path(sys.argv[1]))
