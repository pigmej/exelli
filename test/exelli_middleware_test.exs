defmodule ExelliTest.Test.Middleware do
  use ExUnit.Case

  @base_url "http://localhost:4000"

  defmacro request!(method, target) do
    quote do
      HTTPoison.request!(unquote(method), unquote(@base_url) <> unquote(target))
    end
  end

  setup_all do
    {:ok, pid} = Exelli.elli_start [{Exelli.TestHandler.Middleware, [prefix: ["middleware1"]]},
                                    {Exelli.TestHandler.SubSimple, [prefix: ["sub"]]},
                                    {Exelli.TestHandler.Simple, [prefix: []]}]
    on_exit &Exelli.elli_stop/0
    {:ok, pid: pid}
  end

  test "middleware" do
    res = request! :GET, "/middleware1"
    assert res.status_code == 404
  end

  test "sub handler is still working" do
    res = request! :GET, "/sub/ping"
    assert res.status_code == 200
    assert res.body == "PONG sub"
  end


  test "no prefix handler is still working" do
    res = request! :GET, "/ping"
    assert res.status_code == 200
    assert res.body == "PONG"
  end
end
