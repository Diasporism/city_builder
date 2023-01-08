defmodule ECS.Entity do
  defmacro __using__(options) do
    entity          = __CALLER__.module
    {_, components} = List.keyfind(options, :components, 0, {:components, []})
    {_, state}      = List.keyfind(options, :state, 0, {:state, quote do: %{}})

    quote bind_quoted: [entity: entity, components: components, state: state], unquote: true do
      use GenServer

      @components components
      @state      state

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
        {:ok, %{}}
      end

      defmodule Supervisor do
        use DynamicSupervisor

        @entity entity

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
