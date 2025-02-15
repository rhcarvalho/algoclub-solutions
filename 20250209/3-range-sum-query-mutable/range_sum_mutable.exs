ExUnit.start()

defmodule RangeSumMutableTest do
  use ExUnit.Case

  test "leetcode_examples" do
    rs = RangeSumMutable.new([1, 3, 5])
    assert RangeSumMutable.sum(rs, 0..2) == 9

    rs = RangeSumMutable.update(rs, 1, 2)
    assert RangeSumMutable.sum(rs, 0..2) == 8
  end
end

defmodule RangeSumMutable do
  def new(nums) do
    [0 | nums]
    |> Enum.scan(&+/2)
    |> List.to_tuple()
  end

  def sum(rs, left..right//_) do
    elem(rs, right + 1) - elem(rs, left)
  end

  # TODO: This is not efficient. Study topics:
  # - Segment Tree
  # - Fenwick Tree
  def update(rs, i, val) do
    diff = val - original_value_at(rs, i)

    rs
    |> Tuple.to_list()
    |> Enum.with_index()
    |> Enum.map(fn {v, k} ->
      if k > i do
        v + diff
      else
        v
      end
    end)
    |> List.to_tuple()
  end

  defp original_value_at(rs, i) do
    sum(rs, i..i)
  end
end
