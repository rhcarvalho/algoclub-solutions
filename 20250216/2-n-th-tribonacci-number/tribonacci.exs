ExUnit.start()

defmodule TribonacciTest do
  use ExUnit.Case

  test "leetcode_examples" do
    assert Tribonacci.nth(4) == 4
    assert Tribonacci.nth(25) == 1_389_537
  end

  test "more" do
    assert Tribonacci.nth(0) == 0
    assert Tribonacci.nth(1) == 1
    assert Tribonacci.nth(2) == 1
    assert Tribonacci.nth(3) == 2
    assert Tribonacci.nth(5) == 7
    assert Tribonacci.nth(37) == 208_287_610_3
  end
end

defmodule Tribonacci do
  def nth(n) do
    for _ <- 3..n//1, reduce: [1, 1, 0] do
      [a, b, c | _] -> [a + b + c, a, b]
    end
    |> Enum.drop(max(0, 2 - n))
    |> hd()
  end
end
