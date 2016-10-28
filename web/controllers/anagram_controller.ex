defmodule Anagrammerator.AnagramController do
  use Anagrammerator.Web, :controller

  #plug :action

  def index(conn, %{}) do
    {:ok, result} = Anagrammerator.Agent.all()
    render conn, "index.html", res: result
  end

  def query(conn, %{"query" => query}) do
    {:ok, result} = Anagrammerator.Agent.query(query)
    IO.inspect(result)
    render conn, "index.html", res: result
  end
end
