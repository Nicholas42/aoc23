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

def find_reflection_vert(map)
  lines = map.split("\n")
  length = lines[0].length - 1

  (1..length).each  do |index|
    is_reflection = true
    lines.each do |line|
      next if check_reflected(line, index)

      is_reflection = false
      break
    end

    return index if is_reflection
  end

  nil
end

def find_reflection_hor(map)
  lines = map.split("\n")
  length = lines.length - 1

  (1..length).each do |index|
    return index if check_reflected(lines, index)
  end

  nil
end

sum = 0
input.each do |map|
  vert = find_reflection_vert(map) || 0
  hor = find_reflection_hor(map) || 0

  sum += vert + 100 * hor
end

puts sum
