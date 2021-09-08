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
    assert chaining() == 7
  end

  test "working with tuples" do 
    person = {"Chris", 37}
    assert elem(person, 0) == "Chris"
    assert elem(person, 1) == 37

    assert put_elem(person, 1, 38) == {"Chris", 38}
    assert person == {"Chris", 37} # put_elem does not modify, returns new version
  end

  test "working with maps" do
    person = %{name: "Chris", age: 37} #if keys are atoms, there is shorthand
    person2 = %{:name => "Ruth", :age => 36} 

    assert person[:name] == "Chris"
    assert person2[:age] == 36
    assert person.name == "Chris" # again atoms are special
    assert person2.name == "Ruth"

    person2 = %{person2 | age: 37} # note, you cant add new fields
    assert person2.age == 37

    person2 = Map.put(person2, :salary, 100)
    assert person2.salary == 100
  end

  test "strings" do 
    _ = "This
    is
    multiline"

    _ = """
    I dont understand the etymology of heredoc (this is what these are called)
    but it must end on its own line """
    """

    assert "Hello, world" == "Hello, " <> "world"
  end

  test "first class functions" do 
    square = fn(x) ->
      x * x
    end

    # & is known as the capture operator (/1 bit is the arity)
    # captures a function and turns it into a lambda
    multiplyBy2 = &LearnElixirWithTests.multiplyBy2/1

    list = [1, 2]

    assert square.(3) == 9
    assert Enum.map(list, square) == [1, 4]
    assert Enum.map(list, fn(x) -> x+2 end) == [3, 4]
    assert Enum.map(list, fn(x) -> LearnElixirWithTests.multiplyBy2(x) end) == [2, 4]
    assert Enum.map(list, multiplyBy2) == [2, 4]
  end

  test "closures" do
    some_var = 5

    my_lambda = fn(x) ->
      LearnElixirWithTests.add(x, some_var)
    end


    assert my_lambda.(2) == 7
  end

  test "range" do 
    range = 1..3
    assert 2 in range
    refute 4 in range
  end

  test "keyword list, list of pairs. Often used to let clients pass arbitary number of optional arguments" do 
    days = [{:monday, 1}, {:tuesday, 2}]
    other_syntax = [monday: 1, tuesday: 2]

    assert days == other_syntax
    assert Keyword.get(days, :monday) == 1
    assert Keyword.get(days, :bob) == nil
    assert days[:monday] == 1

    assert Float.to_string(1/3, [decimals: 2]) == "0.33"
    # can omit the square brackets if last argument is a keyword list
    assert Float.to_string(1/3, decimals: 1) == "0.3"

    assert LearnElixirWithTests.optional_fun(2) == 4
    assert LearnElixirWithTests.optional_fun(2, multiplier: 3) == 6
  end

  test "Map (was HashDict) is a kv thing but performant for larger collections" do
    myDict = [monday: 1, tuesday: 2, wednesday: 3] |> Enum.into(Map.new)
    assert Map.get(myDict, :tuesday) == 2  

    myDict2 = Map.put(myDict, :thursday, 4)
    assert Map.get(myDict, :thursday) == nil
    assert Map.get(myDict2, :thursday) == 4

    # Map is enumerable, so we can use Enum functions, but presumably order isn't predictable
    stuff = Enum.map(myDict2, fn key_value ->  
      key = elem(key_value, 0)
      value = elem(key_value, 1)
      "#{key}-#{value}"
      end
    )

    assert hd(stuff) == "monday-1"
  end

  test "MapSet (was HashSet), pretty obvious" do 
    days = [:monday, "wtf", "wtf", 123] |> Enum.into(MapSet.new)

    assert Enum.count(days) == 3
  end

end
