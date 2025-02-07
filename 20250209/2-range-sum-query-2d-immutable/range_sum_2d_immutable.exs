ExUnit.start()

defmodule RangeSum2DImmutableTest do
  use ExUnit.Case

  test "leetcode_examples" do
    rs =
      RangeSum2DImmutable.new([
        [3, 0, 1, 4, 2],
        [5, 6, 3, 2, 1],
        [1, 2, 0, 1, 5],
        [4, 1, 0, 1, 7],
        [1, 0, 3, 0, 5]
      ])

    # rs |> Tuple.to_list() |> Enum.each(&IO.inspect/1)

    assert RangeSum2DImmutable.query(rs, 2, 1, 4, 3) == 8
    assert RangeSum2DImmutable.query(rs, 1, 1, 2, 2) == 11
    assert RangeSum2DImmutable.query(rs, 1, 2, 2, 4) == 12
  end
end

defmodule RangeSum2DImmutable do
  def new([row | _] = matrix) do
    # create a matrix of sums with an extra column and row to avoid bounds
    # checking. The first row and column are all zeros.

    first_row_sums = [Tuple.duplicate(0, length(row) + 1)]

    matrix
    |> Enum.reduce(first_row_sums, fn row, [previous_row_sums | _] = sum_matrix ->
      row_sums =
        row
        |> Enum.reduce({1, 0, [0]}, fn n, {j, sum, sums} ->
          sum = sum + n
          {j + 1, sum, [sum + elem(previous_row_sums, j) | sums]}
        end)
        |> elem(2)
        |> Enum.reverse()
        |> List.to_tuple()

      [row_sums | sum_matrix]
    end)
    |> Enum.reverse()
    |> List.to_tuple()
  end

  def query(rs, top, left, bottom, right) do
    br = rs |> elem(bottom + 1) |> elem(right + 1)
    tr = rs |> elem(top) |> elem(right + 1)
    bl = rs |> elem(bottom + 1) |> elem(left)
    tl = rs |> elem(top) |> elem(left)

    br - tr - bl + tl
  end
end
