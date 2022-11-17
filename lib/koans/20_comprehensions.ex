defmodule Comprehensions do
  use Koans

  @intro "A comprehension is made of three parts: generators, filters, and collectibles. We will look at how these interact with eachother"

  koan "The generator, `n <- [1, 2, 3, 4]`, is providing the values for our comprehension" do
    assert (for n <- [1, 2, 3], do: n * n) == [1, 4, 9]
  end

  koan "Any enumerable can be a generator" do
    assert (for n <- 1..3, do: n * n) == [1, 4, 9]
  end

  koan "A generator specifies how to extract values from a collection" do
    collection = [["Hello","World"], ["Apple", "Pie"]]
    assert (for [a, b] <- collection, do: "#{a} #{b}")
      # |> String.downcase
      |> Enum.map(&String.downcase/1)
      == ["hello world", "apple pie"]
  end

  koan "You can use multiple generators at once" do
    assert (for x <- ["little", "big"],
      y <- ["dogs", "cats"], do: "#{x} #{y}")
      == ["little dogs", "little cats", "big dogs", "big cats"]
  end

  koan "Use a filter to reduce your work" do
    assert (for n <- [1, 2, 3, 4, 5, 6], n > 3, do: n) == [4, 5, 6]
  end

  koan "Add the result of a comprehension to an existing collection" do
    collection = for x <- ["Pecan", "Pumpkin"], into: %{}, do: {x, "#{x} Pie"}
    # maps can have string keys which have different syntax
    assert collection != %{Pecan: "Pecan Pie", Pumpkin: "Pumpkin Pie"}
    assert collection == %{"Pecan" => "Pecan Pie", "Pumpkin" => "Pumpkin Pie"}
  end

end
