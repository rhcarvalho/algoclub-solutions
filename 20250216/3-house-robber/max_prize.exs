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
  end
end

defmodule MaxPrize do
  @moduledoc """
  ## Intuition

  Possible prize patterns:
  - 0, 1, 0, 1, 0, 1, 0, ...
  - 1, 0, 1, 0, 1, 0, 1, ...

  Facts:
  - For each prize, we can either take it or skip it.
  - We can't take two consecutive prizes.
  - Since prize values are always positive, we should always take as many prizes
    as possible.

  ## Example Steps

      [a]: we take a
      [a, b]: we take the max(b, a)

      [a, b, c]: we take the max(c + a, b)
      [a, b, c, d]: we take the max(d + b, c + a)
      [a, b, c, d, e]: we take the max(e + c + a, d + b)

  We are, in fact, taking the max of the sum of each partition of the input
  list. The partitions made of alternating elements.
  """

  def calc(prizes) do
    for c <- prizes, reduce: [0, 0] do
      [b, a] -> [c + a, b]
    end
    |> Enum.max()
  end
end
