ExUnit.start


Application.ensure_all_started(:httpoison)
Logger.configure_backend(:console, colors: [enabled: false], metadata: [:request_id])


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

end
