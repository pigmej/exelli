defmodule ExelliTest.Test.Handler do
  use ExUnit.Case

  setup do
    {:ok, pid} = Exelli.elli_start Exelli.TestHandler
    {:ok, pid: pid}
  end

  test "ping" do
    assert 1 + 1 == 2
  end
end
