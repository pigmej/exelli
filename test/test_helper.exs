ExUnit.start


Application.ensure_all_started(:httpoison)
Logger.configure_backend(:console, colors: [enabled: false], metadata: [:request_id])


defmodule Exelli.TestHandler do
  use Exelli.Handler

  def handle(:GET, ["test", a], _req, _args) when a == "a" do
    {:ok, "A"}
  end

  get ["ping"] do
    {:ok, "PONG"}

  end
  
  get ["test"] do
    {:ok, "WORKS"}
  end

  get ["test", y, yy] when y == "1" and yy == "2" do
    {:ok, "y"}
  end

end
