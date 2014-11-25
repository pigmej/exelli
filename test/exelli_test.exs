defmodule ExelliTest.Test.Handler do
  use ExUnit.Case

  @base_url "http://localhost:4000/"

  defmacro get!(target) do
    quote do
      HTTPoison.get! (unquote(@base_url) <> unquote(target))
    end
  end

  setup_all do
    {:ok, pid} = Exelli.elli_start Exelli.TestHandler.Simple
    {:ok, pid: pid}
  end

  test "very basic one" do
    res = get! ""
    assert res.status_code == 200
    assert res.body == "HELLO"
  end

  test "very basic one #2" do
    res = get! "/ping"
    assert res.status_code == 200
    assert res.body == "PONG"
  end

  test "very basic one #3" do
    res = get! "/test"
    assert res.status_code == 200
    assert res.body == "WORKS"
  end
end
