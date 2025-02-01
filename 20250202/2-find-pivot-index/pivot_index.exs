ExUnit.start()

defmodule PivotIndexTest do
  require Logger
  use ExUnit.Case

  test "leetcode_examples" do
    assert PivotIndex.find([1, 7, 3, 6, 5, 6]) == 3
    assert PivotIndex.find([1, 2, 3]) == -1
    assert PivotIndex.find([2, 1, -1]) == 0
  end

  test "alternative_implementation" do
    assert PivotIndex.find_fast([1, 7, 3, 6, 5, 6]) == 3
    assert PivotIndex.find_fast([1, 2, 3]) == -1
    assert PivotIndex.find_fast([2, 1, -1]) == 0
  end

  test "compare" do
    nums = Enum.map(1..10000, fn _ -> Enum.random(-1000..1000) end)

    {time_slow, result_slow} = :timer.tc(fn -> PivotIndex.find(nums) end)
    {time_fast, result_fast} = :timer.tc(fn -> PivotIndex.find_fast(nums) end)

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
    Pivot Index comparison

    Index: #{result_slow}

    Slow:    #{time_slow |> format_thousands.(10)}µs
    Fast:    #{time_fast |> format_thousands.(10)}µs
    Speedup: #{round(time_slow / time_fast) |> format_thousands.(10)}x
    """
    |> Logger.info()
  end
end

defmodule PivotIndex do
  def find(nums) do
    0..(length(nums) - 1)
    |> Enum.find(-1, fn i ->
      left_sum =
        nums
        |> Enum.take(i)
        |> Enum.sum()

      right_sum =
        nums
        |> Enum.drop(i + 1)
        |> Enum.sum()

      left_sum == right_sum
    end)
  end

  def find_fast(nums) do
    range_sum =
      [0 | nums]
      |> Enum.scan(&+/2)
      |> List.to_tuple()

    0..(length(nums) - 1)
    |> Enum.find(-1, fn i ->
      left_sum = elem(range_sum, i)
      right_sum = elem(range_sum, tuple_size(range_sum) - 1) - elem(range_sum, i + 1)
      left_sum == right_sum
    end)
  end
end
