defmodule Exelli.Supervisor do
  use Supervisor


  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = []
    supervise(children, strategy: :one_for_one)
  end

  def elli_start(elli_name, options) do
    Supervisor.start_child(__MODULE__, worker(:elli, [options], [id: elli_name]))
  end

  def elli_stop(elli_name) do
    case Supervisor.terminate_child(__MODULE__, elli_name) do
      :ok -> Supervisor.delete_child(__MODULE__, elli_name)
      err -> err
    end
  end
end
