defmodule AnagrammeratorTest do
  use ExUnit.Case
  doctest Anagrammerator

  test "the truth" do
    assert 1 + 1 == 2
  end

  Anagrammerator.process_word("AA", Map.new())

  Anagrammerator.load

end
