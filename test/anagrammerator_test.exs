defmodule AnagrammeratorTest do
  use ExUnit.Case
  doctest Anagrammerator

  setup do
    {:ok, agror} = Anagrammerator.start_link
    {:ok, agror: agror}
  end

  test "query word", %{ agror: agror } do
    {:ok, result} = Anagrammerator.query(agror, "AA")
    assert result === ["AA"]
  end

end
