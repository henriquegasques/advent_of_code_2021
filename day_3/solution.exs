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

  defp diagnostic_report do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end
end

Solution.part_one()
