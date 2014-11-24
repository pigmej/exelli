defmodule Exelli.Callback do
  @behaviour :elli_handler
  @moduledoc false

  require :elli_request, as: R

  def handle(req, args) do
    handle(R.method(req), R.path(req), req, args)
  end

  def handle(:GET, ["ping"], req, args) do
    {:ok, "PONG"}
  end


  def handle_event(_event, _data, _args) do
    # IO.inspect _event
    # IO.inspect _data
    # IO.inspect _args
    :ok
  end

end
