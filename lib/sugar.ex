defmodule Exelli.Router do

  defmacro __using__(_opts) do
    quote do

      Module.register_attribute(__MODULE__, :handlers, accumulate: true)

      import Exelli.Router

      @before_compile Exelli.Router
    end
  end


  defmacro enable(hndl, opts) do
    quote do
      Module.put_attribute __MODULE__, :handlers, {unquote(hndl), unquote(opts)}
    end
  end

  defmacro enable(hndl) do
    quote do
      Module.put_attribute __MODULE__, :handlers, {unquote(hndl), []}
    end
  end


  defmacro __before_compile__(env) do
    handlers = Module.get_attribute(env.module, :handlers)
    handlers = case Enum.count(handlers) do
                 1 -> Enum.at(handlers, 0)
                 _ -> handlers
               end
    quote do
      def get_handlers() do
        unquote(handlers)
      end
    end
  end
end

