ExUnit.start()

defmodule LongestPalindromeTest do
  use ExUnit.Case

  test "leetcode examples" do
    assert LongestPalindrome.find("babad") in ~w(bab aba)
    assert LongestPalindrome.find("cbbd") == "bb"
  end

  test "more" do
    assert LongestPalindrome.find("a") == "a"
    assert LongestPalindrome.find("ac") == "a"
    assert LongestPalindrome.find("aca") == "aca"
    thousand_as = String.duplicate("a", 1000)
    assert LongestPalindrome.find(thousand_as) == thousand_as
    many_bs = String.duplicate("b", 598)
    many_bs_with_cd = String.duplicate("b", 400) <> "cd" <> many_bs
    assert LongestPalindrome.find(many_bs_with_cd) == many_bs
  end
end

defmodule LongestPalindrome do
  def find(s) do
    for i <- (byte_size(s) - 1)..0//-1, j <- i..(byte_size(s) - 1)//1, reduce: MapSet.new() do
      palindromes ->
        if palindrome?(s, palindromes, i, j) do
          MapSet.put(palindromes, {i, j})
        else
          palindromes
        end
    end
    |> Enum.min_by(fn {i, j} -> {i - j, i} end)
    |> then(fn {i, j} -> binary_slice(s, i..j) end)
  end

  defp palindrome?(s, p, i, j) do
    (j - i < 2 || MapSet.member?(p, {i + 1, j - 1})) && :binary.at(s, i) == :binary.at(s, j)
  end
end
