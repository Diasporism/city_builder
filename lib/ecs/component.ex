defmodule ECS.Component do
  defmacro __using__(options) do
    component       = __CALLER__.module
    {_, attributes} = List.keyfind(options, :attributes, 0, {:attributes, []})
    {_, tags}       = List.keyfind(options, :tags, 0, {:tags, []})

    quote bind_quoted: [component: component, attributes: attributes, tags: tags], unquote: true do
      @component  component
      @attributes attributes
      @tags       tags
    end
  end
end
