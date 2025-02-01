ExUnit.start()

defmodule SubarraySumTest do
  require Logger
  use ExUnit.Case

  test "leetcode_examples" do
    assert SubarraySum.count([1, 1, 1], 2) == 2
    assert SubarraySum.count([1, 2, 3], 3) == 2
  end

  test "extra_examples" do
    assert SubarraySum.count([1, 2, 3, 4, 5], 10) == 1
    assert SubarraySum.count([1, 1, 1], 1) == 3
  end

  test "compare" do
    nums = Enum.map(1..10_000, fn _ -> Enum.random(-1_000..1_000) end)
    k = Enum.random(-10_000_000..10_000_000)

    {time_slow, result_slow} = :timer.tc(fn -> SubarraySum.count(nums, k) end)
    {time_fast, result_fast} = :timer.tc(fn -> SubarraySum.count_single_pass(nums, k) end)

    assert time_fast < time_slow
    assert result_fast == result_slow

    format_thousands = fn time, padding ->
      time
      |> Integer.to_charlist()
      |> Enum.reverse()
      |> Enum.chunk_every(3)
      |> Enum.join(",")
      |> String.reverse()
      |> String.pad_leading(padding)
    end

    """
    Subarray Sum Equals k comparison

    Slow:    #{time_slow |> format_thousands.(10)}µs
    Fast:    #{time_fast |> format_thousands.(10)}µs
    Speedup: #{round(time_slow / time_fast) |> format_thousands.(10)}x
    """
    |> Logger.info()
  end
end

defmodule SubarraySum do
  def count(nums, k) do
    cumulative_sum =
      [0 | nums]
      |> Enum.scan(&+/2)

    cumulative_sum_minus_k =
      cumulative_sum
      |> Enum.map(&(&1 - k))

    frequency =
      cumulative_sum
      |> Enum.reduce(%{}, fn sum, acc ->
        Map.update(acc, sum, 1, &(&1 + 1))
      end)

    Enum.sum_by(cumulative_sum_minus_k, &Map.get(frequency, &1, 0))
  end

  def count_single_pass(nums, k) do
    nums
    |> Enum.reduce({%{0 => 1}, 0, 0}, fn num, {cum_sum_seen, cum_sum, count} ->
      cum_sum = cum_sum + num
      count = count + Map.get(cum_sum_seen, cum_sum - k, 0)
      cum_sum_seen = Map.update(cum_sum_seen, cum_sum, 1, &(&1 + 1))
      {cum_sum_seen, cum_sum, count}
    end)
    |> elem(2)
  end
end
