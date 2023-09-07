defmodule Adel.Parkings.Parking do
  @moduledoc """
  Parking Poitiers Ecto schema.

  field :geo_point_2d, :map is still to be dealt correctly from HTML but not only.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "parkings" do
    field :nom, :string
    field :places, :integer
    field :capacite, :integer
    field :derniere_mise_a_jour_base, :naive_datetime
    field :derniere_actualisation_bo, :naive_datetime
    field :taux_doccupation, :float
    field :geo_point_2d, :map
    field :parking_id, :integer

    timestamps()
  end

  @doc false
  def changeset(parking, attrs) do
    attrs =
      attrs
      |> cast_places_to_int()
      |> cast_capacite_to_int()

    parking
    |> cast(attrs, [
      :nom,
      :places,
      :capacite,
      :derniere_mise_a_jour_base,
      :derniere_actualisation_bo,
      :taux_doccupation,
      :geo_point_2d,
      :parking_id
    ])
    |> validate_required([
      :nom,
      :places,
      :capacite,
      :derniere_mise_a_jour_base,
      :derniere_actualisation_bo,
      :taux_doccupation,
      :geo_point_2d,
      :parking_id
    ])
  end

  defp cast_places_to_int(%{"places" => places} = attrs) when is_float(places),
    do: attrs |> Map.put("places", places |> Kernel.trunc())

  defp cast_places_to_int(attrs), do: attrs

  defp cast_capacite_to_int(%{"capacite" => capacite} = attrs) when is_float(capacite),
    do: attrs |> Map.put("capacite", capacite |> Kernel.trunc())

  defp cast_capacite_to_int(attrs), do: attrs
end
