defmodule LearnElixirWithTests do

  @the_comma_thing ", "

  @doc "greet will greet you in a friendly way"
  def greet(name \\ "World", language \\ :english) do 
    greeting_prefix(language) <> @the_comma_thing <> name
  end

  @doc ~S"""
  Returns 2

  ## Examples

      iex> LearnElixirWithTests.multiplyBy2(1)
      2

      iex> LearnElixirWithTests.multiplyBy2(2)
      4

  """
  def multiplyBy2(x) do
    x*2
  end

  def chaining do
    -5 
   |> abs
   |> IO.inspect(label: "IO inspect lets you debug value within chains") 
   |> add(2)
  end

  def add(x, y), do: x + y

  defp greeting_prefix(language) do 
    case language do
      :spanish -> "Hola"
      :french -> "Bonjour"
      _ -> "Hello"
    end
  end

end
