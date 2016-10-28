defmodule Anagrammerator do
  use Application

  def start(_type, _args) do
    Anagrammerator.Supervisor.start_link
  end
end
