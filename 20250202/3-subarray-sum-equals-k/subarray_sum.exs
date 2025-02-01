ExUnit.start()

defmodule SubarraySumTest do
  use ExUnit.Case

  test "leetcode_examples" do
    assert SubarraySum.count([1, 1, 1], 2) == 2
    assert SubarraySum.count([1, 2, 3], 3) == 2
  end

  test "extra_examples" do
    assert SubarraySum.count([1, 2, 3, 4, 5], 10) == 1
    assert SubarraySum.count([1, 1, 1], 1) == 3
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

    set = MapSet.new(cumulative_sum)
    Enum.count(cumulative_sum_minus_k, &MapSet.member?(set, &1))
  end
end
