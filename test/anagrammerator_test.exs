defmodule AnagrammeratorTest do
  use ExUnit.Case

  setup context do
    {:ok, agror} = Anagrammerator.Server.start_link(context.test)
    {:ok, agror: agror}
  end

  test "query word", %{ agror: agror } do
    {:ok, result} = Anagrammerator.Server.query(agror, "AA")
    assert result === ["AA"]
  end

  test "removes state on crash", %{ agror: agror } do
    {:ok, result} = Anagrammerator.Server.query(agror, "AA")
    assert result === ["AA"]
    # Stop the bucket with non-normal reason
    Process.exit(agror, :shutdown)

    # Wait until the bucket is dead
    ref = Process.monitor(agror)
    assert_receive {:DOWN, ^ref, _, _, _}

    assert Anagrammerator.Server.query(agror, "AA") === :error
  end


end
