defmodule Systems.Age do
  use ECS.System, target_tags: [:ageable]
end
