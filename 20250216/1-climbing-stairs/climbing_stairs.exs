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

  def count(n) do
    for _ <- 3..n, reduce: [2, 1] do
      [count_n_minus_1, count_n_minus_2 | _] = acc -> [count_n_minus_1 + count_n_minus_2 | acc]
    end
    |> hd()
  end
end
