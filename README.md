# ExAliyunAMQP.Connection

This library is built on [amqp](https://hex.pm/packages/amqp) and make a simple wrapper for `AMQP.Connection` within Alibaba AMQP product's authorization.

## Installation

Adding `ex_aliyun_amqp` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_aliyun_amqp,  "~> 0.1"}
  ]
end
``` 

## Sample

```elixir

  def main() do
    options = [
      access_id: "",
      secret_key: "",
      owner_id: "",
      host: "",
      virtual_host
    ]

    {:ok, connection} = ExAliyunAMQP.Connection.open(options)

    # The returned `connection` is an AMQP.Connection, and then
    # can be used for the ongoing call to AMQP.Channel.open/1 .
  end

```

## Reference

[Idiomatic Elixir client for RabbitMQ](https://github.com/pma/amqp)  
[Erlang RabbitMQ Client library](http://www.rabbitmq.com/erlang-client-user-guide.html)  
