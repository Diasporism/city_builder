defmodule CityBuilder do
  use Application

  def start(_type, _options) do
    children = [
      ECS.Registry,
      Entities.Person.Supervisor,
      Entities.Road.Supervisor
    ]

    Supervisor.start_link(children, name: __MODULE__, strategy: :one_for_one)
  end
end
