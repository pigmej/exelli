ExUnit.start


Application.ensure_all_started(:httpoison)
Logger.configure_backend(:console, colors: [enabled: false])


defmodule Exelli.TestHandler.Simple do
  use Exelli.Handler

  get [] do
    {:ok, "HELLO"}
  end

  get ["ping"] do
    {:ok, "PONG"}

  end

  get ["test"] do
    {:ok, "WORKS"}
  end

  post ["test"] do
    {:ok, "POST WORKS"}
  end

end


defmodule Exelli.TestHandler.SubSimple do
  use Exelli.Handler

  get [] do
    {:ok, "HELLO sub"}
  end

  get ["ping"] do
    {:ok, "PONG sub"}

  end

  get ["test"] do
    {:ok, "WORKS sub"}
  end

  post ["test"] do
    {:ok, "POST WORKS sub"}
  end

end



defmodule Exelli.TestHandler.Middleware do
  use Exelli.Handler

  def handle(_, _) do
    :ignore
  end

end


defmodule Exelli.TestRouter do

  use Exelli.Router

  enable Exelli.TestHandler.Middleware, [prefix: ["middleware"]]
  enable Exelli.TestHandler.SubSimple, "sub"
  enable Exelli.TestHandler.Simple, [prefix: []]

end
