defmodule ExAliyunAMQP.Connection do
  @moduledoc """
  Simple wrapper for `AMQP.Connection` within Alibaba AMQP product's authorization.
  """

  @doc """
  Similar as `AMQP.Connection.open/2`, but there are some options are different.

  ## Options
    * `:access_id` - The access_id of Alibaba resource access management for AMQP product, it is instead of `username` option (required);
    * `:secret_key` - The secret_key of Alibaba resource access management for AMQP product, it is instead of `password` option (required);
    * `:owner_id` - The id of Alibaba cloud account (required);
    * `:host` - The hostname of the Alibaba AMQP product broker (required);
    * `:virtual_host` - The name of a virtual host in the Alibaba AMQP product broker (required);
    * `:port` - The port the broker is listening on (defaults to `5672`);
    * `:channel_max` - The channel_max handshake parameter (defaults to `0`);
    * `:frame_max` - The frame_max handshake parameter (defaults to `0`);
    * `:heartbeat` - The hearbeat interval in seconds (defaults to `10`);
    * `:connection_timeout` - The connection timeout in milliseconds (defaults to `50000`);
    * `:ssl_options` - Enable SSL by setting the location to cert files (defaults to `:none`);
    * `:client_properties` - A list of extra client properties to be sent to the server, defaults to `[]`;
    * `:socket_options` - Extra socket options. These are appended to the default options. \
                          See http://www.erlang.org/doc/man/inet.html#setopts-2 and http://www.erlang.org/doc/man/gen_tcp.html#connect-4 \
                          for descriptions of the available options.

  """
  @spec open(keyword, String.t() | :undefined) ::
          {:ok, AMQP.Connection.t()} | {:error, atom()} | {:error, any()}
  def open(options \\ [], name \\ :undefined) do
    AMQP.Connection.open(options(options), name)
  end

  @doc """
  Closes an open Connection.
  """
  @spec close(AMQP.Connection.t()) :: :ok | {:error, any}
  defdelegate close(connection), to: AMQP.Connection

  @doc """
  Prepare options of connection with Alibaba AMQP product's authorization, please see options of open/2 for details.
  """
  @spec options(keyword) :: keyword
  def options(options) do
    access_id = get_required(options, :access_id)
    secret_key = get_required(options, :secret_key)
    owner_id = get_required(options, :owner_id)

    get_required(options, :host)
    get_required(options, :virtual_host)

    Keyword.merge(options, [
      username: username(owner_id, access_id),
      password: password(secret_key)
    ])
  end

  defp get_required(options, key) do
    case Keyword.get(options, key) do
      nil ->
        raise "`#{key}` is required but got it as nil."
      value ->
        value
    end
  end

  defp username(owner_id, access_id) do
    "0:#{owner_id}:#{access_id}" |> Base.encode64()
  end

  defp password(secret_key) do
    now = :erlang.system_time(:millisecond) |> to_string
    signature = :crypto.hmac(:sha, now, secret_key) |> Base.encode16()
    "#{signature}:#{now}" |> Base.encode64()
  end

end
