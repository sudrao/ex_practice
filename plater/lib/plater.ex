defmodule Plater do
  @moduledoc """
  Documentation for Plater.
  """

  @doc """
  Template interpreter.

  ## Examples

      iex> Plater.plate("<html></html>")
      "<html></html>"

  """
  @spec plate(String.t(), List) :: String.t()
  def plate(tem, varmap \\ %{}) do
    match = ~r/\<%=(.*)%\>/U

    # replace each ref in original template
    # split at each matched expression, keeping expressions
    parts = String.split(tem, match, include_captures: true, trim: true)

    cond do
      # nothing to replace, return as is
      parts == [] ->
        tem

      true ->
        # go over parts and replace matches with equivalent text
        parts =
          Stream.map(parts, fn part ->
            term = Regex.run(match, part, capture: :all_but_first)

            if term do
              [term] = term
              varmap[term |> String.trim()] |> html_safe
            else
              part
            end
          end)

        Enum.join(parts)
    end
  end

  @doc "Make unsafe string safe"
  def html_safe(str) do
    str
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
  end
end
