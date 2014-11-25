defmodule Exelli.Callback do
  # @behaviour :elli_handler
  # @moduledoc false

  # require :elli_request, as: R

  # def handle(req, args) do
  #   handle(R.method(req), R.path(req), req, args)
  # end

  use Exelli.Handler

  def handle(:GET, ["ping"], _req, _args) do
    {:ok, "OK"}
  end

  def handle(:GET, ["test", a], _req, _args) when a == "a" do
    {:ok, "A"}
  end

  get ["test"] do
    {:ok, "WORKS"}
  end

  get ["test", y, yy] when y == "1" and yy == "2" do
    {:ok, "y"}
  end

end
