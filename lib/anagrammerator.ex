defmodule Anagrammerator do

  def load do
    #unzip archive, requesting binary in memory
    {:ok, filelist} = :zip.unzip('assets/deutsch_d25_utf8.txt.zip', [:memory])
    #there is just one text file in that
    {_, content} = List.first(filelist)
    #get the words out of the content
    words = toWords(content)

    #process words (dict impl)
    dict = toDict(words)

    IO.puts(dict)
  end

  defp toWords(content) do
    lines = String.split(content, "\n")
    Enum.map(lines, fn(line) ->
      List.first(String.split(line, " "))
    end)
  end

  defp toDict(words) do
    #first impl, create a dict with sorted letters as keys and all words with those letters as values.
    List.foldl(words, Map.new(), &processWord(&1,&2))
  end

  def processWord(word, wordmap) do
    #we only need the first word on the line
    #quick implementation - sort and insert into map
    chars = String.split(word, "")
    sorted = Enum.join(Enum.sort(chars))
    Map.update(wordmap, sorted, [word], fn (val) -> val ++ word end)
  end
end
