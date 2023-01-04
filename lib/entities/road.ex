defmodule Entities.Road do
  use ECS.Entity, distance: 1, load: 0

  def handle_cast(message, state) do
    state = case message do
      :increment ->
        %{state | load: state.load + 1}
      :decrement ->
        %{state | load: state.load - 1}
    end
    {:noreply, state}
  end
end
