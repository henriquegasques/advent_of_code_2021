defmodule Solution do
  def part_one do
    positions = %{ horizontal: 0, depth: 0 }

    File.read!("input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.reduce(positions, &update_position/2)
    |> Map.values
    |> Enum.reduce(&(&1 * &2))
    |> IO.puts
  end

  defp update_position(["forward", amount], position) do
    %{ position | horizontal: position[:horizontal] + String.to_integer(amount) }
  end

  defp update_position(["down", amount], position) do
    %{ position | depth: position[:depth] + String.to_integer(amount) }
  end

  defp update_position(["up", amount], position) do
    %{ position | depth: position[:depth] - String.to_integer(amount) }
  end
end

Solution.part_one()
