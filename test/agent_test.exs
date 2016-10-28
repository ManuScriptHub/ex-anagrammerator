defmodule Anagrammerator.AgentTest do
  use ExUnit.Case, async: true

  test "has data" do
    {:ok, result} = Anagrammerator.Agent.query("AA")
    assert result == ["AA"]
  end
  test "all data" do
    assert {:ok, _} = Anagrammerator.Agent.all()
  end
  test "removes data on exit" do
    assert {:ok, _} = Anagrammerator.Agent.query("AA")
    Anagrammerator.Agent.stop()
    assert Anagrammerator.Agent.query("AA") == :error
  end
  #
  # test "removes data on crash", %{ agent: agent } do
  #   {:ok, result} = Anagrammerator.Agent.query(agent, "AA")
  #   assert result === ["AA"]
  #   # Stop the bucket with non-normal reason
  #   Process.exit(agent, :shutdown)
  #
  #   # Wait until the bucket is dead
  #   ref = Process.monitor(agent)
  #   assert_receive {:DOWN, ^ref, _, _, _}
  #
  #   assert Anagrammerator.Agent.query(agent, "AA") == :error
  # end

end
