defmodule Anagrammerator.ServerTest do
  use ExUnit.Case, async: true

  setup context do
    {:ok, agror} = Anagrammerator.Server.start_link(context.test)
    {:ok, agror: agror}
  end

  test "has data", %{agror: agror} do
    {:ok, result } = Anagrammerator.Server.query(agror, "AA")
    assert result === ["AA"]
  end

  test "removes data on exit", %{agror: agror} do
    assert {:ok, _} = Anagrammerator.Server.query(agror, "AA")
    Agent.stop(agror)
    assert Anagrammerator.Server.query(agror, "AA") == :error
  end

end
