defmodule Exelli.Handler do
  defmacro __using__(_opts) do

    quote do
      @before_compile Exelli.Handler

      @behaviour :elli_handler

      require :elli_request, as: R

      def handle(req, args) do
        handle(R.method(req), R.path(req), req, args)
      end


      import Exelli.Handler

    end

  end


  defmacro expose(method, {:when, _, [path, guards]}, do: code) do
    quote do
      def handle(unquote(method), unquote(path), req, args) when unquote(guards) do
        unquote(code)
      end
    end
  end

  defmacro expose(method, path, do: code) do
    quote do
      def handle(unquote(method), unquote(path), req, args) do
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


  # # TODO: handle / print errors somehow
  defmacro __before_compile__(_env) do
    quote do
      def handle(_, _, _, _), do: :ignore
      def handle_event(_, _, _), do: :ok
    end
  end

end
