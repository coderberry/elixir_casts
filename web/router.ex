defmodule ElixirCasts.Router do
  use ElixirCasts.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  scope "/", ElixirCasts do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ElixirCasts do
    pipe_through :api

    get "/", ApiController, :index
    resources "/episodes", EpisodeController
  end
end
