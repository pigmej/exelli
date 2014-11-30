defmodule Exelli.Handler do
  defmacro __using__(_opts) do

    quote location: :keep do
      @before_compile Exelli.Handler

      @behaviour :elli_handler

      require :elli_request, as: R

      def handle(req, :undefined) do
        match(R.method(req), R.path(req), req, :undefined)
      end

      def handle(req, []) do
        match(R.method(req), R.path(req), req, [])
      end


      def handle(req, args) do
        # TODO: optimize prefix
        prefix = args[:prefix]
        path = R.path(req)
        case prefix do
                 nil -> match(R.method(req), path, req, args)
                 [] -> match(R.method(req), path, req, args)
                 arr -> handle_with_prefix(req, path, prefix, args)
        end
      end

      defp handle_with_prefix(req, path, prefix, args) do
        case Exelli.prefix_match(path, prefix) do
          false -> :ignore
          true -> match(R.method(req), path |> Enum.drop(Enum.count(prefix)), req, args)
        end
      end

      def handle_event(_, _, _) do
        :ok
      end

      # def match(_, _, _, _), do: :ignore

      import Exelli.Handler

      # defoverridable [match: 4, handle_event: 3, handle: 2]
      defoverridable [handle_event: 3, handle: 2]

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

  defmacro patch(options, do: code) do
    quote do
      expose :PATCH, unquote(options) do
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
      def match(_, _, _, _), do: :ignore
    end
  end

end
