defmodule Adel.SuperTrucs.Utilisateurs do
  @moduledoc """
  Utilisateurs Ecto schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "utilisateurs" do
    field :prenom, :string
    field :nom, :string
    field :age, :integer

    timestamps()
  end

  @doc false
  def changeset(utilisateurs, attrs) do
    utilisateurs
    |> cast(attrs, [:prenom, :nom, :age])
    |> validate_required([:prenom, :nom, :age])
  end
end
