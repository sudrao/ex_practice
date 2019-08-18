defmodule Cap do
  @moduledoc """
  Documentation for Cap.
  """

  @base "https://api.pagerduty.com/users"
  @token "y_NbAkKc66ryYTWUXYEu"

  def get_url(url) do
    with %{status_code: 200, body: body} <- request(:get, url)
    do
      body
    else
      %{status_code: 404} -> raise Cap.NotFoundError
      _ -> raise RuntimeError
    end
  end
  
  def get_users() do
    get_url(@base) |> Poison.decode! |> Map.get("users")
  end
 
 
  def get_user(id) do
    get_url(@base <> "/#{id}") |> Poison.decode!
  end
 
  def show_users() do
    get_users()
    |> Enum.map(fn user ->
      %{
        id: user["id"],
        name: user["name"],
        email: user["email"],
        contact_methods: user["contact_methods"]
      }
    end)
  end

  def show_user(id) do
    user = get_user(id)["user"]
    %{
        id: user["id"],
        name: user["name"],
        email: user["email"],
        contact_methods: user["contact_methods"] |> Enum.map(fn method ->
          url = method["self"]
          get_url(url)
          |> Poison.decode!
          |> Map.get("contact_method")
          |> Map.get("address")
        end)
      }
  end
    
  defp request(method, url) do
    HTTPoison.request!(method, url, "", [
    {"Accept", "application/vnd.pagerduty+json;version=2"},
    {"Authorization", "Token token=#{@token}"}
    ])
  end
  
  defmodule NotFoundError do
    defexception message: "Not Found"
  end
    
end
