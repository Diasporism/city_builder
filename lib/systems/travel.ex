defmodule Systems.Travel do
  use ECS.System, target_tags: [:travelable]
end
