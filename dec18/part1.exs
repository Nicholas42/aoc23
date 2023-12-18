#!/bin/elixir

Code.require_file("area.ex")

defmodule Part1 do
  def run() do
    [input_file] = System.argv()
    IO.puts(read_file(input_file) |> Area.trapozoid_formula())
  end

  defp read_file(input_file) do
    File.stream!(input_file)
    |> Stream.map(&String.split/1)
    |> Stream.filter(&(length(&1) > 0))
    |> Stream.map(&read_move/1)
  end

  defp read_move([direction_string, length_string, _]) do
    len = String.to_integer(length_string)
    case direction_string do
      "U" -> {0, -1 * len }
      "R" -> {len, 0}
      "D" -> {0, len}
      "L" -> {-1*len, 0}
    end
  end
end

Part1.run()
