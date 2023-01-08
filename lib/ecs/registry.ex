defmodule ECS.Registry do
  def child_spec(_arg) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start, []},
      restart: :transient
    }
  end

  def start do
    Registry.start_link(
      keys: :duplicate,
      name: __MODULE__,
      partitions: System.schedulers_online()
    )
  end

  def broadcast(entity_type, message) do
    Registry.dispatch(__MODULE__, entity_type, fn entities ->
      for {entity, _} <- entities, do: GenServer.cast(entity, message)
    end)
  end
end
