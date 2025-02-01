ExUnit.start()

defmodule RangeSumTest do
  use ExUnit.Case

  test "leetcode_examples" do
    rs = RangeSum.new([-2, 0, 3, -5, 2, -1])
    assert RangeSum.sum(rs, 0..2) == 1
    assert RangeSum.sum(rs, 2..5) == -1
    assert RangeSum.sum(rs, 0..5) == -3
  end
end

defmodule RangeSum do
  def new(nums) do
    [0 | nums]
    |> Enum.scan(&+/2)
    |> List.to_tuple()
  end

  def sum(rs, left..right//_) do
    elem(rs, right + 1) - elem(rs, left)
  end
end
