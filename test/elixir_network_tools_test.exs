defmodule ElixirNetworkToolsTest do
  use ExUnit.Case, async: true
  doctest ElixirNetworkTools

  test "decode's string from Base16 to ASCII" do
    assert {:ok, "Something Awesome"} === ElixirNetworkTools.decode("536f6d657468696e6720417765736f6d65")
  end

  test "non-printable ASCII characters are replaced by period characters" do
    assert {:ok, "Something Awesom."} === ElixirNetworkTools.decode("536f6d657468696e6720417765736f6d00")
  end

  test "multiple non printable characters are replaced by period characters" do
    assert {:ok, "............."} === ElixirNetworkTools.decode("2e2e2e2e2e2e2e2e2e2e2e2e2e")
  end
end
