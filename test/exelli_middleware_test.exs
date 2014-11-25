defmodule ExelliTest.Test.Middleware do
  use ExUnit.Case

  @base_url "http://localhost:4000/"

  defmacro request!(method, target) do
    quote do
      HTTPoison.request!(unquote(method), unquote(@base_url) <> unquote(target))
    end
  end

  setup_all do
    {:ok, pid} = Exelli.elli_start [{Exelli.TestHandler.Middleware, [prefix: ["middleware1"]]}]
    on_exit &Exelli.elli_stop/0
    {:ok, pid: pid}
  end

  test "middleware" do
    res = request! :GET, "/middleware1"
    assert res.status_code == 200
    assert res.body == "middleware"
  end

end
