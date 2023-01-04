defmodule ECS.Component do
  defmacro __using__(_options) do
    quote do
      import ECS.Component
    end
  end
end
