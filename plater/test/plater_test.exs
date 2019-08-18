defmodule PlaterTest do
  use ExUnit.Case
  doctest Plater

  test "simple template, no vars" do
    assert Plater.plate("world") == "world"
  end

  test "has var" do
    vars = %{"var1" => "hello", "var2" => "world"}
    assert Plater.plate("<%= var1 %> <%= var2 %>", vars) == "hello world"
  end

  test "has repeated var" do
    vars = %{"var1" => "hello", "var2" => "world"}
    assert Plater.plate("<%= var1 %> <%= var1 %>", vars) == "hello hello"
  end

  test "has script injection" do
    vars = %{"var1" => "<script>hello", "var2" => "</script>"}

    assert Plater.plate("<html><%= var1 %> <%= var2 %></html>", vars) ==
             "<html>&lt;script&gt;hello &lt;/script&gt;</html>"
  end
end
