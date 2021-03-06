defmodule AncestryEcto.Descendant do
  @moduledoc false

  import Ecto.Query
  import AncestryEcto.Utils

  alias AncestryEcto.Children

  def list(model, opts) do
    query(model, opts)
    |> repo(opts).all
  end

  def ids(model, opts) do
    for child <- list(model, opts), do: Map.get(child, attribute_column(opts))
  end

  def query(model, opts) do
    from(u in module(opts),
      where:
        field(u, ^column(opts)) == ^Children.ancestry(model, opts) or
          like(field(u, ^column(opts)), ^"#{Children.ancestry(model, opts)}/%")
    )
  end
end
