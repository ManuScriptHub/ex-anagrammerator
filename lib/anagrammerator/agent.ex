defmodule Anagrammerator.Agent do
  @doc """
  Starts a new bucket.
  """
  def start_link do
    Agent.start_link(fn -> loadInitialState end, name: __MODULE__)
  end

  def query(letters) do
    key = to_key(letters)
    {:ok, Agent.get(__MODULE__, fn map -> Map.get(map, key, []) end)}
  end
  def all do
    {:ok, Agent.get(__MODULE__, fn map -> Map.keys(map) end)}
  end
  def stop do
    Agent.stop(__MODULE__, :normal)
  end
  # ================== private implementation =====================
  defp loadInitialState do
    #unzip archive, requesting binary in memory
    {:ok, filelist} = :zip.unzip('priv/deutsch_d25_utf8.txt.zip', [:memory])
    #there is just one text file in that
    {_, content} = List.first(filelist)
    #get the words out of the content
    content
    |> to_words
    |> Enum.reduce(Map.new(), &process_word/2)
  end

  defp to_words(content) do
    content
    |> String.split("\n")
    |> Enum.map(&first_word/1)
  end

  defp first_word(line) do
    line
    |> String.split(" ")
    |> List.first
  end

  defp process_word(word, wordmap) do
    Map.update(wordmap, to_key(word), [word], fn (val) -> val ++ [word] end)
  end

  defp to_key(word) do
    String.split(word,"")
    |> Enum.sort
    |> Enum.join
  end
end
