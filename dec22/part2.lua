#!/bin/env lua

require("common")

local function contains(set, elem)
    for _, candidate in pairs(set) do
        if candidate == elem then
            return true
        end
    end
    return false
end
local function containsAllOf(superset, subset)
    for _, elem in pairs(subset) do
        if not contains(superset, elem) then
            return false
        end
    end
    return true
end

local function removeSupport(removedSupports, supports)
    local start_removed = #removedSupports
    for index, sups in pairs(supports) do
        if not contains(removedSupports, index) and containsAllOf(removedSupports, sups) then
            removedSupports[# removedSupports + 1] = index
        end
    end
    return start_removed < #removedSupports
end

local function checkChainReaction(brickIndex, supports)
    local removedSupports = { brickIndex }
    while removeSupport(removedSupports, supports) do
        -- pass
    end
    return #removedSupports - 1
end

local bricks = ReadFile("input.txt")
local overlaps = ComputeOverlaps(bricks)
FallAll(bricks, overlaps)

local supports = FindDirectSupports(bricks, overlaps)

local chainDestruction = 0

for index, _ in ipairs(bricks) do
    chainDestruction = chainDestruction + checkChainReaction(index, supports)
end

print(chainDestruction)
