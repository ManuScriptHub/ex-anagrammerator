defmodule Anagrammerator.Server do
  use GenServer

  def start_link(name) do
    #starts the server (see init)
    {:ok, _} = GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def init(:ok) do
    {:ok, agent} = Anagrammerator.Agent.start_link
    Anagrammerator.Agent.put(agent, "words", loadInitialState)
    agentMonitor = Process.monitor(agent)
    {:ok, {agent, agentMonitor}}
  end

  def query(pid, args) do
    GenServer.call(pid, {:query, args})
  end
  # ================== genserver callbacks =====================

  def handle_call({:query, letters}, _from, {agent, _} = state ) do
    data = Anagrammerator.Agent.get(agent, "words")
    key = to_key(letters)
    {:reply, Map.fetch(data, key), state}
  end

  def handle_info({:DOWN, _ref, :process, _pid, _reason}, _state) do
    IO.puts "got down"
    {:noreply, %{}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  # ================== private implementation =====================
  defp loadInitialState do
    #unzip archive, requesting binary in memory
    {:ok, filelist} = :zip.unzip('assets/deutsch_d25_utf8.txt.zip', [:memory])
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
    Map.update(wordmap, to_key(word), [word], fn (val) -> [val | word] end)
  end

  defp to_key(word) do
    String.split(word,"")
    |> Enum.sort
    |> Enum.join
  end
end
