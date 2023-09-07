defmodule Adel.SuperTrucs.Produits do
  @moduledoc """
  Produits Ecto schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "produits" do
    field :nom, :string
    field :categorie, :string
    field :nombre, :integer

    timestamps()
  end

  @doc false
  def changeset(produits, attrs) do
    produits
    |> cast(attrs, [:nom, :categorie, :nombre])
    |> validate_required([:nom, :categorie, :nombre])
  end
end
