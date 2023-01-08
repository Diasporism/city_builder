defmodule Components.Attachable do
  use ECS.Component, attributes: [attached_entities: []], tags: [:attachable]
end
