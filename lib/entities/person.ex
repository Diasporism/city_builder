defmodule Entities.Person do
  use ECS.Entity, components: [Components.Ageable], state: %{name: nil, age: nil}

  def handle_cast(_message, state) do
    {:noreply, state}
  end
end
