defmodule Exelli do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    Exelli.Supervisor.start_link
  end

  def elli_start(handler, options \\ []) do
    Exelli.Supervisor.elli_start(handler, options)
  end

  def elli_stop(name \\ :default_elli) do
    Exelli.Supervisor.elli_stop(name)
  end

end
