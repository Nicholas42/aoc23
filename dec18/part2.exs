#!/bin/elixir

Code.require_file("area.ex")

defmodule Part2 do
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

  defp read_move([_, _, color]) do
    {length_string, direction_string} = color
      |> String.replace(["(", ")", "#"], "")
      |> String.split_at(-1)
    len = String.to_integer(length_string, 16)

    case direction_string do
      "0" -> {len, 0}
      "1" -> {0, len}
      "2" -> {-1*len, 0}
      "3" -> {0, -1 * len }
    end
  end
end

Part2.run()
