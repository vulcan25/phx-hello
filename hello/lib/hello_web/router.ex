defmodule HelloWeb.Router do
  use HelloWeb, :router

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

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:id", HelloController, :show
    resources "/users", UserController 
    resources "/users", UserController do
      resources "/posts", PostController
    end
    
    forward "/jobs", BackgroundJob.Plug, name: "Hello Phoenix"
    
    resources "/reviews", ReviewController
  end

  scope "/admin", HelloWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/reviews", ReviewController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end
end
