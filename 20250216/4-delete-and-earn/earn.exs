ExUnit.start()

defmodule EarnTest do
  use ExUnit.Case

  test "leetcode examples" do
    assert Earn.max([3, 4, 2]) == 6
    assert Earn.max([2, 2, 3, 3, 3, 4]) == 9
  end
end

defmodule Earn do
  @moduledoc """
  ## Intuition

  For each number we see, we can either "delete and earn" it or skip it.
  As we consume the input, we can keep track of two totals: one for earning the
  previous number and one for skipping it.

  It would be easier to process the input if it was sorted, so I can easily tell
  nums[i] + 1, nums[i] and nums[i] - 1 apart, as they are adjacent.

  Even after sorting, it is not obvious what future a higher number will have if
  I didn't earn it in an earlier step. It may or may not be deleted depending on
  future decisions.

  Given 3 consecutive numbers a, b, and c, I can either earn a and c, or b.
  Since they are consecutive, a + c >= b, because n + n + 2 > n + 1, for n > 0.

  But the numbers might repeat in the input, so it might be beneficial to earn a
  smaller number multiple times, instead of earning a larger number once.

  Since earning a number keeps other copies of itself in the input, I can
  consider the value of each number the sum of all its copies in the input.

  2: 2
  3: 9
  4: 4

  For numbers that are not consecutive, just take them all.

  So now this problem is similar to the house robber problem, where I can't take
  two consecutive sums.

  ## Example Steps

  [3, 4, 2] => sorted to [4, 3, 2]
  Options: sum([4, 2]) = 6, or sum([3]) = 3

  [2, 2, 3, 3, 3, 4] => sorted to [4, 3, 3, 3, 2, 2]
  Options: sum([4, 2, 2]) = 8, or sum([3, 3, 3]) = 9
  """

  def max(nums) do
    {prizes, max_n} =
      for n <- nums, reduce: {%{}, 0} do
        {prizes, max_n} -> {Map.update(prizes, n, n, &(&1 + n)), max(n, max_n)}
      end

    for c <- 1..max_n, reduce: [0, 0] do
      [b, a] -> [Map.get(prizes, c, 0) + a, b]
    end
    |> Enum.max()
  end
end
