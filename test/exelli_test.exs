defmodule ExelliTest.Test.Handler do
  use ExUnit.Case

  @base_url "http://localhost:4000/"

  defmacro request!(method, target) do
    quote do
      HTTPoison.request!(unquote(method), unquote(@base_url) <> unquote(target))
    end
  end

  setup_all do
    {:ok, pid} = Exelli.elli_start Exelli.TestHandler.Simple
    on_exit &Exelli.elli_stop/0
    {:ok, pid: pid}
  end

  test "very basic one" do
    res = request! :GET, ""
    assert res.status_code == 200
    assert res.body == "HELLO"
  end

  test "very basic one #2" do
    res = request! :GET, "/ping"
    assert res.status_code == 200
    assert res.body == "PONG"
  end

  test "very basic one #3" do
    res = request! :GET, "/test"
    assert res.status_code == 200
    assert res.body == "WORKS"
  end

  test "very basic one #4" do
    res = request! :POST, "/test"
    assert res.status_code == 200
    assert res.body == "POST WORKS"
  end

end
