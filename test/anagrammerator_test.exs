defmodule AnagrammeratorTest do
  use ExUnit.Case
  doctest Anagrammerator

  test "the truth" do
    assert 1 + 1 == 2
  end

  Anagrammerator.processWord("AA", Map.new())

  Anagrammerator.load

end
