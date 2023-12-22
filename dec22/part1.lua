#!/bin/env lua

require("common")

local function distinct(array)
    table.sort(array)
    local result = { array[0] }
    local last = array[0]
    for _, elem in pairs(array) do
        if elem ~= last then
            last = elem
            result[#result + 1] = elem
        end
    end

    return result
end

local function findSingleSupports(directSupports)
    local singleSupports = {}
    for _, sups in ipairs(directSupports) do
        if #sups == 1 and sups[1] ~= "Ground" then
            singleSupports[#singleSupports + 1] = sups[1]
        end
    end
    return distinct(singleSupports)
end

local bricks = ReadFile("input.txt")
local overlaps = ComputeOverlaps(bricks)
FallAll(bricks, overlaps)
local directSupports = FindDirectSupports(bricks, overlaps)
local singleSupports = findSingleSupports(directSupports)

print(#bricks - #singleSupports)
