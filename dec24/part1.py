#!/bin/env python3
import re
import sys
from dataclasses import dataclass
from pathlib import Path


@dataclass
class Hailstone:
    px: int
    py: int
    pz: int
    vx: int
    vy: int
    vz: int


def readInput(fname: Path) -> list[Hailstone]:
    numberRegex = re.compile(r"-?\d+")
    result = []
    with open(fname) as f:
        for line in f:
            result.append(Hailstone(*map(int, numberRegex.findall(line))))

    return result


def multiply(lhs: list[list[float]], rhs: list[list[float]]) -> list[list[float]]:
    result = []
    for row in lhs:
        resultRow = []
        for coli in range(len(rhs[0])):
            resultRow.append(sum(row[index] * rhs[index][coli] for index in range(len(row))))

        result.append(resultRow)

    return result


def intersectXY(a: Hailstone, b: Hailstone) -> tuple[float, float] | None:
    det = a.vx * b.vy - a.vy * b.vx
    if det == 0:
        # parallel
        return None
    inverse = [[b.vy / det, -b.vx / det], [-a.vy / det, a.vx / det]]
    [[t], [s]] = multiply(inverse, [[b.px - a.px], [b.py - a.py]])
    if t < 0 or s > 0:
        # In the past
        return None

    return (a.px + t * a.vx, a.py + t * a.vy)


def calculateIntersections(stones: list[Hailstone]) -> list[tuple[float, float]]:
    result = []
    for i in range(len(stones)):
        for j in range(i + 1, len(stones)):
            intersection = intersectXY(stones[i], stones[j])
            if intersection is not None:
                result.append(intersection)

    return result


def inRange(coord: float) -> bool:
    return 200000000000000 <= coord and coord <= 400000000000001


def countInArea(intersections: list[tuple[float, float]]) -> int:
    return len(list(filter(lambda sec: inRange(sec[0]) and inRange(sec[1]), intersections)))


def main(inputPath: Path):
    stones = readInput(inputPath)
    intersections = calculateIntersections(stones)
    print(countInArea(intersections))


if __name__ == "__main__":
    main(Path(sys.argv[1]))
