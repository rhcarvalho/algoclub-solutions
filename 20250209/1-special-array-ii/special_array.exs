ExUnit.start()

defmodule SpecialArrayTest do
  use ExUnit.Case

  test "leetcode_examples" do
    a = SpecialArray.new([3, 4, 1, 2, 6])
    assert SpecialArray.query(a, [0..4]) == [false]

    a = SpecialArray.new([4, 3, 1, 6])
    assert SpecialArray.query(a, [0..2, 2..3]) == [false, true]
  end
end

defmodule SpecialArray do
  import Bitwise
  import Integer, only: [mod: 2]

  def new(nums) do
    nums
    |> Enum.reduce({0, 0, []}, fn
      n, {color, last, colors} ->
        parity = mod(n, 2)
        color = color + bnot(bxor(parity, last)) &&& 1
        {color, parity, [color | colors]}
    end)
    |> elem(2)
    |> Enum.reverse()
    |> List.to_tuple()
  end

  def query(a, ranges) do
    ranges
    |> Enum.map(fn first..last//_ -> elem(a, first) == elem(a, last) end)
  end
end
