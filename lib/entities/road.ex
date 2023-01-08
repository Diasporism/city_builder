defmodule Entities.Road do
  use ECS.Entity, components: [Components.Travelable, Components.Attachable], state: %{ distance: 1 }
end
