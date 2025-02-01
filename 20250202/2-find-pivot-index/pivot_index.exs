ExUnit.start()

defmodule PivotIndexTest do
  use ExUnit.Case

  test "leetcode_examples" do
    assert PivotIndex.find([1, 7, 3, 6, 5, 6]) == 3
    assert PivotIndex.find([1, 2, 3]) == -1
    assert PivotIndex.find([2, 1, -1]) == 0
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
end
