ExUnit.start()

defmodule ClimbingStairsTest do
  use ExUnit.Case

  test "leetcode_examples" do
    assert ClimbingStairs.count(2) == 2
    assert ClimbingStairs.count(3) == 3
  end

  test "more" do
    assert ClimbingStairs.count(4) == 5
    assert ClimbingStairs.count(5) == 8
    assert ClimbingStairs.count(45) == 1_836_311_903
  end
end

defmodule ClimbingStairs do
  def count(1), do: 1
  def count(2), do: 2
  def count(n), do: count(n - 1) + count(n - 2)
end
