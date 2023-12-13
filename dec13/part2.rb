#!/bin/env ruby

if ARGV.empty?
  puts 'Usage: ./part1.rb <input>'
  exit 1
end

input = File.read(ARGV[0]).split("\n\n")

def check_reflected(str, index)
  split = [index, str.length - index].min
  lhs = str[(index - split)..index - 1]
  rhs = str[index..(index + split - 1)]
  lhs == rhs.reverse
end

def find_reflection_vert(map, skip)
  lines = map.split("\n")
  length = lines[0].length - 1

  (1..length).each  do |index|
    is_reflection = true
    next if index == skip

    lines.each do |line|
      next if check_reflected(line, index)

      is_reflection = false
      break
    end

    return index if is_reflection
  end

  nil
end

def find_reflection_hor(map, skip)
  lines = map.split("\n")
  length = lines.length - 1

  (1..length).each do |index|
    return index if index != skip && check_reflected(lines, index)
  end

  nil
end

def other(char)
  if char == '.'
    '#'
  else
    '.'
  end
end

def get_value(map)
  length = map.length
  orig_vert = find_reflection_vert(map, nil)
  orig_hor = find_reflection_hor(map, nil)
  (0..length).each do |index|
    char = map[index]
    next if char == "\n"

    map[index] = other char

    vert = find_reflection_vert(map, orig_vert)
    return vert if vert

    hor = find_reflection_hor(map, orig_hor)

    return 100 * hor if hor

    map[index] = char
  end
end

sum = 0
input.each do |map|
  sum += get_value(map)
end

puts sum
