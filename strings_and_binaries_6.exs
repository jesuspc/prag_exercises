defmodule Capitalize do
  def capitalize_sentences(<<>>) do
    _capitalize_sentences(<<>>, <<>>)
  end
  def capitalize_sentences(<< head, tail :: binary >>) do
    _capitalize_sentences(tail, << _upcase(head) >>)
  end

  defp _capitalize_sentences(<<>>, converted_string) do
    converted_string
  end
  defp _capitalize_sentences(<< 46, 32, head, tail :: binary >>, converted_string) do
    _capitalize_sentences(tail, converted_string <> << 46, 32 >> <> << _upcase(head) >>)
  end
  defp _capitalize_sentences(<< head, tail :: binary >>, converted_string) do
    _capitalize_sentences(tail, converted_string <> << _downcase(head) >>)
  end

  defp _upcase(ascii_char) when ascii_char >= 97 and ascii_char <= 122 do
    ascii_char - 32
  end
  defp _upcase(ascii_char) do
    ascii_char
  end
  defp _downcase(ascii_char) when ascii_char >= 65 and ascii_char < 97 do
    ascii_char + 32
  end
  defp _downcase(ascii_char) do
    ascii_char
  end
end

ExUnit.start

defmodule CapitalizeTest do
  use ExUnit.Case, async: true

  test "it works for a complicated string" do
    assert Capitalize.capitalize_sentences("sOme Com. plic. AtEd stRing") == "Some com. Plic. Ated string"
  end
end

