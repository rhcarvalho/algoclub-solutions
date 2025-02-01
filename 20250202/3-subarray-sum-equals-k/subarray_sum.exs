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
