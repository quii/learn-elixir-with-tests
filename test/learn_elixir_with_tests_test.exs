defmodule LearnElixirWithTestsTest do
  use ExUnit.Case
  doctest LearnElixirWithTests
  import LearnElixirWithTests

  test "greet people" do 
    assert greet("Chris") == "Hello, Chris"
  end

  test "greet the world when no name is given" do 
    assert greet() == "Hello, World"
  end

  test "greet in spanish" do 
    assert greet("Chris", :spanish) == "Hola, Chris"
  end

  test "greet in french" do 
    assert greet("Chris", :french) == "Bonjour, Chris"
  end

  test "chaining is done with |>, the result is passed in as first arg to the next f" do
    assert chaining == 7
  end

  test "working with tuples" do 
    person = {"Chris", 37}
    assert elem(person, 0) == "Chris"
    assert elem(person, 1) == 37

    assert put_elem(person, 1, 38) == {"Chris", 38}
    assert person == {"Chris", 37} # put_elem does not modify, returns new version
  end

end
