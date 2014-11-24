defmodule Exelli do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    Exelli.Supervisor.start_link
  end
  
end
