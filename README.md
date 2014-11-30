Exelli
======

Elli elixir wrapper with some sugar sytnax goodies.


## Hello world

```elixir
defmodule MyHandler do
  use Exelli.Handler

  get [] do
    {:ok, "HELLO"}
  end

  get ["ping"] do
    {:ok, "PONG"}

  end

  get ["test"] do
    {:ok, "WORKS"}
  end

  post ["test"] do
    {:ok, "POST WORKS"}
  end

end
```

then start elli with

```elixir
{:ok, pid} = Exelli.elli_start MyHandler.Simple
```

## Router


```elixir
defmodule MyRouter do

  use Exelli.Router

  enable MyMiddleware, [prefix: ["middleware"]]
  enable MyHandler

end

```

and you can start it with

```elixir
{:ok, pid} = Exelli.elli_start MyRouter
```

In fact, it's just a sugar syntax. You can still use:

```elixir
{:ok, pid} = Exelli.elli_start [{MyMiddleware, [prefix: ["middleware1"]]}, # normal prefix
                                {MySubSimple, "sub"}, # easy prefix
                                {MySimple, [prefix: []]}] # no prefix
```


## Elli middlewares

You can obviously enable any other elli middleware. Add it to mix.exs, and enable like:

```elixir

defmodule MyRouter do

  use Exelli.Router

  enable MyMiddleware, [prefix: ["middleware"]]
  enable MyHandler
  enable :elli_date

end

```
