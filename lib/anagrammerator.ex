defmodule Anagrammerator do

  def load do
    #unzip archive, requesting binary in memory
    {:ok, filelist} = :zip.unzip('assets/deutsch_d25_utf8.txt.zip', [:memory])
    #there is just one text file in that
    {_, content} = List.first(filelist)
    #get the words out of the content
    dict = content
    |> to_words
    |> to_dict

    IO.puts Enum.join(Map.keys(dict),",")
  end

  defp to_words(content) do
    content
    |> String.split("\n")
    |> Enum.map(&first_word(&1))
    #lines = String.split(content, "\n")
    #Enum.map(lines, &first_word(&1))
  end

  defp first_word(line) do
    line
    |> String.split(" ")
    |> List.first
  end

  defp to_dict(words) do
    #first impl, create a dict with sorted letters as keys and all words with those letters as values.
    List.foldl(words, Map.new(), &process_word(&1,&2))
  end

  def process_word(word, wordmap) do
    #we only need the first word on the line
    #quick implementation - sort and insert into map
    sorted =
      String.split(word,"")
      |> Enum.sort
      |> Enum.join

    Map.update(wordmap, sorted, [word], fn (val) -> val ++ [word] end)
  end
end
