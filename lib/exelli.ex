defmodule Exelli do
  use Application

  @default_elli_name :default_elli

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    Exelli.Supervisor.start_link
  end

  def elli_start(handler) do
    elli_start(handler, [])
  end

  def elli_start(handler, options) when is_atom(handler) do
    {elli_name, options} = Keyword.pop(options, :elli_name, @default_elli_name)
    options = Keyword.put(options, :callback, handler)
    defaults = [{:port, 4000}]
    options = Keyword.merge(defaults, options)
    Exelli.Supervisor.elli_start(elli_name, options)
  end

  def elli_start(handler, options) do
    middleware = [
                   {:callback_args, [mods: handler]}
               ]
    elli_start(:elli_middleware, options ++ middleware)
  end


  def elli_stop(elli_name \\ @default_elli_name) do
    Exelli.Supervisor.elli_stop(elli_name)
  end

end
