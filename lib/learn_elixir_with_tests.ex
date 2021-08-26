defmodule LearnElixirWithTests do

  @the_comma_thing ", "

  @doc "greet will greet you in a friendly way"
  def greet(name \\ "World", language \\ :english) do 
    greeting_prefix(language) <> @the_comma_thing <> name
  end

  def chaining, do: -5 |> abs |> add(2)

  defp add(x, y), do: x + y

  defp greeting_prefix(language) do 
    case language do
      :spanish -> "Hola"
      :french -> "Bonjour"
      _ -> "Hello"
    end
  end

end
