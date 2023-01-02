defmodule Entities.Person do
  alias Entities.Person

  use GenServer

  defstruct name: nil

  def child_spec(_arg) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start, []},
      restart: :transient
    }
  end

  def start do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_arg) do
    {:ok, _} = Registry.register(ECS.Registry, :people, self())
    state = %Person{name: Faker.Person.name()}
    {:ok, state}
  end

  def handle_cast(_message, state) do
    {:noreply, state}
  end
end

defmodule Entities.Supervisors.People do
  alias Entities.Person

  use DynamicSupervisor

  def child_spec(_arg) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start, []},
      restart: :transient
    }
  end

  def start do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def add_person do
    DynamicSupervisor.start_child(__MODULE__, Person)
  end
end
