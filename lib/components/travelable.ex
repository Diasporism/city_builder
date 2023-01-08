defmodule Components.Travelable do
  use ECS.Component, attributes: [position: nil, destination: nil], tags: [:travelable]
end
