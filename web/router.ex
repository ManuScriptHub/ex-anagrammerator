defmodule Anagrammerator.Router do
  use Anagrammerator.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Anagrammerator do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/anagrams", AnagramController, :index
    get "/anagrams/query/:query", AnagramController, :query
  end

  # Other scopes may use custom stacks.
  # scope "/api", Anagrammerator do
  #   pipe_through :api
  # end
end
