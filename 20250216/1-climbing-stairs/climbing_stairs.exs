ExUnit.start()

defmodule ClimbingStairsTest do
  use ExUnit.Case

  test "leetcode_examples" do
    assert ClimbingStairs.count(2) == 2
    assert ClimbingStairs.count(3) == 3
  end

  test "more" do
    assert ClimbingStairs.count(1) == 1
    assert ClimbingStairs.count(4) == 5
    assert ClimbingStairs.count(5) == 8
    assert ClimbingStairs.count(45) == 1_836_311_903
  end
end

defmodule ClimbingStairs do
  def count(n) when n >= 1 and n <= 45 do
    for _ <- 3..n//1, reduce: [2, 1] do
      [count_n_minus_1, count_n_minus_2 | _] ->
        [count_n_minus_1 + count_n_minus_2, count_n_minus_1]
    end
    |> Enum.drop(max(0, 2 - n))
    |> hd()
  end
end
