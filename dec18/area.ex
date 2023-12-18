defmodule Area do
  def trapozoid_formula(points) do
    {summands, _} = points |> Enum.map_reduce({0, 0}, &trapozoid_step/2)
    length = points |> Stream.map(fn {dx, dy} -> abs(dx + dy) end) |> Enum.sum()
    area = Enum.sum(summands) |> abs
    (area + length)/2 + 1 |> round()
  end

  defp trapozoid_step({dx, dy}, {old_x, old_y}) do
    new_x = old_x + dx
    new_y = old_y + dy
    summand = (old_y + new_y) * dx
    {summand, {new_x, new_y}}
  end
end
