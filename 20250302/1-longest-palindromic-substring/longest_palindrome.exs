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
  end
end

defmodule LongestPalindrome do
  def find(s) do
    for i <- 0..String.length(s), j <- 0..String.length(s), j > i do
      String.slice(s, i, j)
    end
    |> Enum.sort_by(&byte_size/1, :desc)
    |> Enum.find(&palindrome?/1)
  end

  defp palindrome?(s) do
    s == String.reverse(s)
  end
end
