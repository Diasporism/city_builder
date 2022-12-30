defmodule CityBuilderTest do
  use ExUnit.Case
  doctest CityBuilder

  test "greets the world" do
    assert CityBuilder.hello() == :world
  end
end
