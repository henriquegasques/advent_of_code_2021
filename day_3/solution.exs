defmodule Solution do
  def part_one do
    diagnostic_report = diagnostic_report()
    half = length(diagnostic_report) / 2 |> round

    # Got some tips from Jose Valim's solution below, but hey, at least I learned a few things :P
    # https://www.twitch.tv/videos/1223929784
    gamma =
      for index <- 0..11 do
        ones_count = Enum.count_until(diagnostic_report, fn binary -> binary |> Enum.at(index) == "1" end, half + 1)
        if ones_count > half, do: ?1, else: ?0
      end

    epsilon = Enum.map(gamma, fn
      ?1 -> ?0
      ?0 -> ?1
    end)

    gamma_as_int = List.to_integer(gamma, 2)
    epsilon_as_int = List.to_integer(epsilon, 2)

    IO.puts gamma_as_int * epsilon_as_int
  end
  
  def part_two do
    diagnostic_report = diagnostic_report()

    oxygen_generator_rating = filter_by_most_common_bit(diagnostic_report, 0)
    co2_scrubber_rating  = filter_by_least_common_bit(diagnostic_report, 0)

    IO.puts oxygen_generator_rating * co2_scrubber_rating
  end

  def filter_by_most_common_bit([oxygen_generator_rating], _pos) do
    oxygen_generator_rating
    |> Enum.join
    |> String.to_charlist
    |> List.to_integer(2)
  end

  def filter_by_most_common_bit(readings, pos) do
    half = length(readings) / 2 |> round

    ones_count = Enum.count_until(readings, fn binary -> binary |> Enum.at(pos) == "1" end, half + 1)
    most_common_bit = if ones_count >= half, do: ?1, else: ?0

    remaining = readings |> Enum.filter(fn reading -> reading |> Enum.at(pos) == <<most_common_bit>> end)
    filter_by_most_common_bit(remaining, pos + 1)
  end

  def filter_by_least_common_bit([co2_scrubber_rating], _pos) do
    co2_scrubber_rating
    |> Enum.join
    |> String.to_charlist
    |> List.to_integer(2)
  end

  def filter_by_least_common_bit(readings, pos) do
    half = length(readings) / 2 |> round

    ones_count = Enum.count_until(readings, fn binary -> binary |> Enum.at(pos) == "1" end, half + 1)
    most_common_bit = if ones_count >= half, do: ?0, else: ?1

    remaining = readings |> Enum.filter(fn reading -> reading |> Enum.at(pos) == <<most_common_bit>> end)
    filter_by_least_common_bit(remaining, pos + 1)
  end

  defp diagnostic_report do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end
end

Solution.part_one()
Solution.part_two()
