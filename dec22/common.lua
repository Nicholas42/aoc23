local function readBrick(line)
    local _, _, x1, y1, z1, x2, y2, z2 = string.find(line, "(%d+),(%d+),(%d+)~(%d+),(%d+),(%d+)")
    return {
        x1 = tonumber(x1),
        y1 = tonumber(y1),
        z1 = tonumber(z1),
        x2 = tonumber(x2),
        y2 = tonumber(y2),
        z2 = tonumber(
            z2)
    }
end

function ReadFile(fname)
    local lines = {}
    for line in io.lines(fname) do
        lines[#lines + 1] = readBrick(line)
    end
    return lines
end

local function intervalsOverlap(min1, max1, min2, max2)
    return not ((min1 > max2) or (min2 > max1))
end

local function overlap(a, b)
    return intervalsOverlap(a["x1"], a["x2"], b["x1"], b["x2"]) and intervalsOverlap(a["y1"], a["y2"], b["y1"], b["y2"])
end

local function findBelow(bricks, index)
    local brick = bricks[index]
    local overlapping = {}
    for i, b in ipairs(bricks) do
        if i == index then
            goto continue
        end
        if overlap(brick, b) and brick["z1"] > b["z2"] then
            overlapping[# overlapping + 1] = i
        end
        ::continue::
    end
    return overlapping
end

local function fallDiff(bricks, overlaps, index)
    local z = bricks[index]["z1"]
    local minDiff = z - 1

    for _, i in pairs(overlaps[index]) do
        local diff = z - bricks[i]["z2"] - 1
        if diff < minDiff then
            minDiff = diff
        end
    end

    return minDiff
end

local function doFall(bricks, overlaps)
    local didFall = false
    for index, brick in ipairs(bricks) do
        local zdiff = fallDiff(bricks, overlaps, index)
        if zdiff > 0 then
            brick["z1"] = brick["z1"] - zdiff
            brick["z2"] = brick["z2"] - zdiff
            didFall = true
        end
    end

    return didFall
end

function ComputeOverlaps(bricks)
    local overlaps = {}

    for index, _ in ipairs(bricks) do
        overlaps[index] = findBelow(bricks, index)
    end

    return overlaps
end

function FallAll(bricks, overlaps)
    while doFall(bricks, overlaps) do
        -- pass
    end
end

function FindDirectSupports(bricks, overlaps)
    local supports = {}
    for index, brick in ipairs(bricks) do
        local supportedBy = {}
        local z = brick["z1"]
        for _, i in pairs(overlaps[index]) do
            if z == bricks[i]["z2"] + 1 then
                supportedBy[#supportedBy + 1] = i
            end
        end
        if #supportedBy == 0 then
            supportedBy = { "Ground" }
        end
        supports[index] = supportedBy
    end
    return supports
end
