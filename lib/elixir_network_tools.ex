defmodule ElixirNetworkTools do
  @doc """
  The decode function takes a hexadecimal payload, such as one generated
  by Snort, and returns the ASCII representation of the string.

  ## Example
  iex> ElixirNetworkTools.decode("436F6E74656E742D4C656E6774683A203132")
  {:ok, "Content-Length: 12"}
  """
  def decode(payload) do
    case _validate_length_of_snort(payload) do
      :error -> raise "Invalid length hex string. Must be even length. Exiting"
      _ -> nil
    end

    decoded = String.upcase(payload)
    |> _do_decode
    |> to_string

    {:ok, decoded}
  end

  @doc """
  Internal function used to manually process the hexadecimal payload,
  and builds a char list of the printable characters. If a character is
  not printable, we instead use periods.

  ## Example
  iex> ElixirNetworkTools._do_decode("436F6E74656E742D4C656E6774683A203132")
  ["Content-Length: 12"]
  """
  def _do_decode(payload) do
    Base.decode16!(payload)
    |> String.chunk(:printable)
    |> Enum.map(fn(chunk) ->
        case String.printable? chunk do
          true -> chunk
          _ -> "."
        end
    end)
  end

  @doc """
  Internal function used to validate the length of the hexadecimal payload.
  Hexadecimal strings should have an even number of characters.

  ## Example
  iex> ElixirNetworkTools._validate_length_of_snort("436F6E74656E742D4C656E6774683A203132")
  :ok
  """
  def _validate_length_of_snort(payload) do
    String.length(payload)
    |> rem(2)
    |> case do
      0 -> :ok
      _ -> :error
    end
  end
end
