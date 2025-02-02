ExUnit.start()

defmodule SubarraySumDivTest do
  use ExUnit.Case

  test "leetcode_examples" do
    assert SubarraySumDiv.count([4, 5, 0, -2, -3, 1], 5) == 7
    assert SubarraySumDiv.count([5], 9) == 0
  end
end

defmodule SubarraySumDiv do
  def count(nums, k) do
    nums
    |> Enum.reduce({%{0 => 1}, 0, 0}, fn num, {cum_sum_seen, cum_sum, count} ->
      cum_sum = cum_sum + num
      count = count + Map.get(cum_sum_seen, Integer.mod(cum_sum - k, k), 0)
      cum_sum_seen = Map.update(cum_sum_seen, Integer.mod(cum_sum, k), 1, &(&1 + 1))
      {cum_sum_seen, cum_sum, count}
    end)
    |> elem(2)
  end
end
