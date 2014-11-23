defmodule Exelli do
  use Application

  def start(_type, args) do
    import Supervisor.Spec, warn: false
    IO.inspect args
    IO.inspect _type

    children = [
                 worker(:elli, [args])
             ]
    # :supervisor.start_child(__MODULE__, worker(:elli, args))
    opts = [strategy: :one_for_one, name: Exelli.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
