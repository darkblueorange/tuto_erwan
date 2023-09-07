defmodule AdelWeb.Router do
  use AdelWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AdelWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AdelWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/produits", ProduitsLive.Index, :index
    live "/produits/new", ProduitsLive.Index, :new
    live "/produits/:id/edit", ProduitsLive.Index, :edit

    live "/produits/:id", ProduitsLive.Show, :show
    live "/produits/:id/show/edit", ProduitsLive.Show, :edit

    resources "/utilisateurs", UtilisateursController

    live "/parkings", ParkingLive.Index, :index
    live "/parkings/new", ParkingLive.Index, :new
    live "/parkings/:id/edit", ParkingLive.Index, :edit

    live "/parkings/:id", ParkingLive.Show, :show
    live "/parkings/:id/show/edit", ParkingLive.Show, :edit

    live "/rochelle_parkings", ParkingRochelleLive.Index, :index
    live "/rochelle_parkings/new", ParkingRochelleLive.Index, :new
    live "/rochelle_parkings/:id/edit", ParkingRochelleLive.Index, :edit

    live "/rochelle_parkings/:id", ParkingRochelleLive.Show, :show
    live "/rochelle_parkings/:id/show/edit", ParkingRochelleLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", AdelWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:adel, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AdelWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
