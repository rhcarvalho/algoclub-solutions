ExUnit.start()

defmodule MaxPrizeTest do
  use ExUnit.Case

  test "leetcode examples" do
    assert MaxPrize.calc([1, 2, 3, 1]) == 4
    assert MaxPrize.calc([2, 7, 9, 3, 1]) == 12
  end

  test "more" do
    assert MaxPrize.calc([1]) == 1
    assert MaxPrize.calc([1, 2]) == 2
    assert MaxPrize.calc([10, 1, 1, 10]) == 20
  end
end

defmodule MaxPrize do
  @moduledoc """
  ## Intuition

  Facts:
  - For each prize, we can either take it or skip it.
  - We can't take two consecutive prizes.
  - The best sum of prizes for N input items is the max of the sum of prizes
    for N-1 items and the sum for N-2 items plus the N-th prize.

  ## Example Steps

      [a]: we take a
      [a, b]: we take the max(b, a)

      [a, b, c]: we take the max(c + a, b)
      [a, b, c, d]: we take the max(d + b, c + a)
      [a, b, c, d, e]: we take the max(e + c + a, d + b)
  """

  def calc(prizes) do
    for c <- prizes, reduce: [0, 0] do
      [b, a] -> [max(c + a, b), b]
    end
    |> hd()
  end
end
