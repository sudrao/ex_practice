defmodule BertTest do
  use ExUnit.Case
  doctest Bert

  test "greets the world" do
    assert Bert.hello() == :world
  end
end
