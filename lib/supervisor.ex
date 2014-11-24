defmodule Exelli.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = []
    supervise(children, strategy: :one_for_one)
  end

  def elli_start(handler) do
    elli_start(:default_elli, handler, [])
  end

  def elli_start(handler, options) do
    elli_start(:default_elli, handler, options)
  end

  def elli_start(name, handler, options) do
    options = Keyword.put(options, :callback, handler)
    defaults = [{:port, 4000}]
    options = Keyword.merge(defaults, options)
    Supervisor.start_child(__MODULE__, worker(:elli, [options], [id: name]))
  end

  def elli_stop() do
    elli_stop(:default_elli)
  end

  def elli_stop(name) do
    case Supervisor.terminate_child(__MODULE__, name) do
      :ok -> Supervisor.delete_child(__MODULE__, name)
      err -> err
    end
  end
end

