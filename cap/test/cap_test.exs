defmodule CapTest do
  use ExUnit.Case
  

  # test "Can get url" do
  #   assert Cap.get_url("https://jsonplaceholder.typicode.com/todos/1") =~ ~r/delectus aut autem/
  # end
  
  # test "Get Bad URL raises error" do
  #   assert_raise(Cap.NotFoundError, fn ->
  #     Cap.get_url("https://jsonplaceholder.typicode.com/badtodo/1")
  #   end)
  # end
  
  # test "Get users" do
  #   assert "" = Cap.show_users()
  # end
  
  test "Show a user" do
    assert "" = Cap.show_user("PGXMBHD")
  end
end
