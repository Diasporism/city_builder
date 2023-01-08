defmodule Components.Ageable do
  use ECS.Component, attributes: [age: 0], tags: [:ageable]

  def handle_cast(:age, state) do
    state = %{state | age: state.age + 1}
    {:noreply, state}
  end
end
