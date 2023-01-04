defmodule Entities.Person do
  use ECS.Entity, name: nil

  def handle_cast(_message, state) do
    {:noreply, state}
  end
end
