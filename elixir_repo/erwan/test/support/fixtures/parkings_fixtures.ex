defmodule Adel.ParkingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Adel.Parkings` context.
  """

  @doc """
  Generate a parking.
  """
  def parking_fixture(attrs \\ %{}) do
    {:ok, parking} =
      attrs
      |> Enum.into(%{
        nom: "some nom",
        places: "some places",
        capacite: "some capacite",
        derniere_mise_a_jour_base: "some derniere_mise_a_jour_base",
        derniere_actualisation_bo: ~N[2023-09-03 16:29:00],
        taux_doccupation: ~N[2023-09-03 16:29:00],
        geo_point_2d: %{},
        parking_id: 42
      })
      |> Adel.Parkings.create_parking()

    parking
  end

  @doc """
  Generate a parking_rochelle.
  """
  def parking_rochelle_fixture(attrs \\ %{}) do
    {:ok, parking_rochelle} =
      attrs
      |> Enum.into(%{
        nb_places: 42,
        nb_autopartage: 42,
        nb_velo: 42,
        nb_velo_dispo: 42,
        nb_2r_el_dispo: 42,
        parking_string_id: "some parking_string_id",
        ylat: 120.5,
        nb_2_rm: 42,
        nb_2_rm_dispo: 42,
        nb_2r_el: 42,
        xlong: 120.5,
        nom: "some nom",
        nb_voitures_electriques: 42,
        nb_places_disponibles: 42,
        nb_pr_dispo: 42,
        nb_pmr: 42,
        coord_y: 120.5,
        coord_x: 120.5,
        nb_voitures_electriques_dispo: 42,
        total_count: 42,
        full_binary_text: "some full_binary_text",
        nb_pmr_dispo: 42,
        nb_pr: 42,
        other_id: 42,
        nb_autopartage_dispo: 42,
        date_comptage: ~N[2023-09-05 23:03:00]
      })
      |> Adel.Parkings.create_parking_rochelle()

    parking_rochelle
  end
end
