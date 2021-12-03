defmodule Solution do
  def part_one do
    position = %{ horizontal: 0, depth: 0 }

    instructions()
    |> Enum.reduce(position, &calculate_position/2)
    |> Map.values
    |> Enum.reduce(&(&1 * &2))
    |> IO.puts
  end

  def part_two do
    position = %{ aim: 0, horizontal: 0, depth: 0 }

    instructions()
    |> Enum.reduce(position, &calculate_position_with_aim/2)
    |> fn %{ horizontal: horizontal, depth: depth, aim: _aim } -> horizontal * depth end.()
    |> IO.puts
  end

  defp calculate_position(["forward", amount], position) do
    %{ position | horizontal: position[:horizontal] + String.to_integer(amount) }
  end

  defp calculate_position(["down", amount], position) do
    %{ position | depth: position[:depth] + String.to_integer(amount) }
  end

  defp calculate_position(["up", amount], position) do
    %{ position | depth: position[:depth] - String.to_integer(amount) }
  end

  defp calculate_position_with_aim(["forward", amount_string], position) do
    amount = String.to_integer(amount_string)
    %{ position | horizontal: position[:horizontal] + amount, depth: position[:depth] + amount * position[:aim] }
  end

  defp calculate_position_with_aim(["down", amount], position) do
    %{ position | aim: position[:aim] + String.to_integer(amount) }
  end

  defp calculate_position_with_aim(["up", amount], position) do
    %{ position | aim: position[:aim] - String.to_integer(amount) }
  end

  defp instructions do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
  end
end

Solution.part_one()
Solution.part_two()
