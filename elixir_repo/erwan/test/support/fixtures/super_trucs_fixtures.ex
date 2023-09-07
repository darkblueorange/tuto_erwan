defmodule Adel.SuperTrucsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Adel.SuperTrucs` context.
  """

  @doc """
  Generate a produits.
  """
  def produits_fixture(attrs \\ %{}) do
    {:ok, produits} =
      attrs
      |> Enum.into(%{
        nom: "some nom",
        categorie: "some categorie",
        nombre: 42
      })
      |> Adel.SuperTrucs.create_produits()

    produits
  end

  @doc """
  Generate a utilisateurs.
  """
  def utilisateurs_fixture(attrs \\ %{}) do
    {:ok, utilisateurs} =
      attrs
      |> Enum.into(%{
        prenom: "some prenom",
        nom: "some nom",
        age: 42
      })
      |> Adel.SuperTrucs.create_utilisateurs()

    utilisateurs
  end
end
