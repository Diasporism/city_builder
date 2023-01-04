defmodule ECS.System do
  defmacro __using__(_options) do
    quote do
      import ECS.Entity
    end
  end
end
