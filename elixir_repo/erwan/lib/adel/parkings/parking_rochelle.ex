defmodule Adel.Parkings.ParkingRochelle do
  @moduledoc """
  Parking Rochelle Ecto schema.

  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "rochelle_parkings" do
    field :nb_places, :integer
    field :nb_autopartage, :integer
    field :nb_velo, :integer
    field :nb_velo_dispo, :integer
    field :nb_2r_el_dispo, :integer
    field :parking_string_id, :string
    field :ylat, :float
    field :nb_2_rm, :integer
    field :nb_2_rm_dispo, :integer
    field :nb_2r_el, :integer
    field :xlong, :float
    field :nom, :string
    field :nb_voitures_electriques, :integer
    field :nb_places_disponibles, :integer
    field :nb_pr_dispo, :integer
    field :nb_pmr, :integer
    field :coord_y, :float
    field :coord_x, :float
    field :nb_voitures_electriques_dispo, :integer
    field :total_count, :integer
    field :full_binary_text, :string
    field :nb_pmr_dispo, :integer
    field :nb_pr, :integer
    field :other_id, :integer
    field :nb_autopartage_dispo, :integer
    field :date_comptage, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(parking_rochelle, attrs) do
    parking_rochelle
    |> cast(attrs, [
      :nb_places,
      :nb_autopartage,
      :nb_velo,
      :nb_velo_dispo,
      :nb_2r_el_dispo,
      :parking_string_id,
      :ylat,
      :nb_2_rm,
      :nb_2_rm_dispo,
      :nb_2r_el,
      :xlong,
      :nom,
      :nb_voitures_electriques,
      :nb_places_disponibles,
      :nb_pr_dispo,
      :nb_pmr,
      :coord_y,
      :coord_x,
      :nb_voitures_electriques_dispo,
      :total_count,
      :full_binary_text,
      :nb_pmr_dispo,
      :nb_pr,
      :other_id,
      :nb_autopartage_dispo,
      :date_comptage
    ])
    |> validate_required([
      :nb_places,
      :nb_autopartage,
      :nb_velo,
      :nb_velo_dispo,
      :nb_2r_el_dispo,
      :parking_string_id,
      :ylat,
      :nb_2_rm,
      :nb_2_rm_dispo,
      :nb_2r_el,
      :xlong,
      :nom,
      :nb_voitures_electriques,
      :nb_places_disponibles,
      :nb_pr_dispo,
      # :nb_pmr,
      :coord_y,
      :coord_x,
      :nb_voitures_electriques_dispo,
      :total_count,
      :full_binary_text,
      :nb_pmr_dispo,
      :nb_pr,
      :other_id,
      :nb_autopartage_dispo,
      :date_comptage
    ])
  end
end
