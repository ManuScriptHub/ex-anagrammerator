defmodule Anagrammerator.AgentTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = Anagrammerator.Agent.start_link
    {:ok, bucket: bucket}
  end

  test "stores wordlist in bucket", %{bucket: bucket} do
    key = "words"
    assert Anagrammerator.Agent.get(bucket,key) == nil
    Anagrammerator.Agent.put(bucket, key, %{a: 1})
    assert Anagrammerator.Agent.get(bucket, key) === %{a: 1}
  end
end
