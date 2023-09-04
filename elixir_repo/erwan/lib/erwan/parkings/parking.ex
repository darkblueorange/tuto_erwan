defmodule Erwan.Parkings.Parking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parkings" do
    field :nom, :string
    field :places, :string
    field :capacite, :string
    field :derniere_mise_a_jour_base, :string
    field :derniere_actualisation_bo, :naive_datetime
    field :taux_doccupation, :naive_datetime
    field :geo_point_2d, :map
    field :parking_id, :integer

    timestamps()
  end

  @doc false
  def changeset(parking, attrs) do
    parking
    |> cast(attrs, [:nom, :places, :capacite, :derniere_mise_a_jour_base, :derniere_actualisation_bo, :taux_doccupation, :geo_point_2d, :parking_id])
    |> validate_required([:nom, :places, :capacite, :derniere_mise_a_jour_base, :derniere_actualisation_bo, :taux_doccupation, :geo_point_2d, :parking_id])
  end
end
