defmodule ECS.Entity do
  defmacro __using__(options) do
    quote bind_quoted: [options: Macro.escape(options, unquote: true)] do
      import ECS.Entity

      use GenServer

      defstruct options

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
        {:ok, _} = Registry.register(ECS.Registry, __MODULE__, self())
        state = struct(__MODULE__, name: Faker.Person.name())
        {:ok, state}
      end

      defmodule Supervisor do
        use DynamicSupervisor

        @entity Enum.at(__ENV__.context_modules, -1)

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

        def add do
          DynamicSupervisor.start_child(__MODULE__, @entity)
        end
      end
    end
  end
end
