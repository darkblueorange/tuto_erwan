defmodule Erwan.ParkingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Erwan.Parkings` context.
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
      |> Erwan.Parkings.create_parking()

    parking
  end
end
