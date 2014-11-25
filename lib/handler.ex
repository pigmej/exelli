defmodule Exelli.Handler do
  defmacro __using__(_opts) do

    quote do
      @before_compile Exelli.Handler

      @behaviour :elli_handler

      require :elli_request, as: R

      def handle(req, :undefined) do
        match(R.method(req), R.path(req), req, :undefined)
      end

      def handle(req, args) do
        # TODO: optimize prefix
        # How to not call it when not necessary ?
        prefix = args[:prefix]
        path = R.path(req) |> Enum.drop(Enum.count(prefix))
        match(R.method(req), path, req, args)
      end

      import Exelli.Handler

    end

  end


  defmacro expose(method, {:when, _, [path, guards]}, do: code) do
    quote do
      def match(unquote(method), unquote(path), req, args) when unquote(guards) do
        unquote(code)
      end
    end
  end

  defmacro expose(method, path, do: code) do
    quote do
      def match(unquote(method), unquote(path), req, args) do
        unquote(code)
      end
    end
  end

  defmacro get(options, do: code) do
    quote do
      expose :GET, unquote(options) do
        unquote(code)
      end
    end
  end

  defmacro post(options, do: code) do
    quote do
      expose :POST, unquote(options) do
        unquote(code)
      end
    end
  end

  defmacro head(options, do: code) do
    quote do
      expose :HEAD, unquote(options) do
        unquote(code)
      end
    end
  end

  defmacro delete(options, do: code) do
    quote do
      expose :DELETE, unquote(options) do
        unquote(code)
      end
    end
  end

  defmacro event(name, do: code) do
    quote do
      def handle_event(unquote(name), data, args) do
        unquote(code)
      end
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def handle_event(:request_error, tb, c) do
        IO.puts "ERROR"
        IO.inspect tb
        :ok
      end
      def handle_event(_, _, _), do: :ok

      def match(_, _, _, _), do: :ignore
    end
  end

end
