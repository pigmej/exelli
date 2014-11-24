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

  defmacro expose(method, path, req, args, do: code) do
    quote do
      def handle(unquote(method), unquote(path), unquote(req), unquote(args)) do
        unquote(code)
      end
    end
  end

  defmacro get(path, req, args, do: code) do
    quote do
      expose(:GET, unquote(path), unquote(req), unquote(args)) do
        unquote(code)
      end
    end
  end

  defmacro post(path, req, args, do: code) do
    quote do
      expose(:POST, unquote(path), unquote(req), unquote(args)) do
        unquote(code)
      end
    end
  end

  defmacro head(path, req, args, do: code) do
    quote do
      expose(:HEAD, unquote(path), unquote(req), unquote(args)) do
        unquote(code)
      end
    end
  end

  defmacro delete(path, req, args, do: code) do
    quote do
      expose(:DELETE, unquote(path), unquote(req), unquote(args)) do
        unquote(code)
      end
    end
  end

  defmacro patch(path, req, args, do: code) do
    quote do
      expose(:PATCH, unquote(path), unquote(req), unquote(args)) do
        unquote(code)
      end
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def handle(_, _, _, _), do: :ignore
      def handle_event(_, _, _), do: :ok
    end
  end

end
