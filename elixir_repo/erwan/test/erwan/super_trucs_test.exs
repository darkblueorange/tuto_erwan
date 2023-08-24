defmodule Erwan.SuperTrucsTest do
  use Erwan.DataCase

  alias Erwan.SuperTrucs

  describe "produits" do
    alias Erwan.SuperTrucs.Produits

    import Erwan.SuperTrucsFixtures

    @invalid_attrs %{nom: nil, categorie: nil, nombre: nil}

    test "list_produits/0 returns all produits" do
      produits = produits_fixture()
      assert SuperTrucs.list_produits() == [produits]
    end

    test "get_produits!/1 returns the produits with given id" do
      produits = produits_fixture()
      assert SuperTrucs.get_produits!(produits.id) == produits
    end

    test "create_produits/1 with valid data creates a produits" do
      valid_attrs = %{nom: "some nom", categorie: "some categorie", nombre: 42}

      assert {:ok, %Produits{} = produits} = SuperTrucs.create_produits(valid_attrs)
      assert produits.nom == "some nom"
      assert produits.categorie == "some categorie"
      assert produits.nombre == 42
    end

    test "create_produits/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SuperTrucs.create_produits(@invalid_attrs)
    end

    test "update_produits/2 with valid data updates the produits" do
      produits = produits_fixture()
      update_attrs = %{nom: "some updated nom", categorie: "some updated categorie", nombre: 43}

      assert {:ok, %Produits{} = produits} = SuperTrucs.update_produits(produits, update_attrs)
      assert produits.nom == "some updated nom"
      assert produits.categorie == "some updated categorie"
      assert produits.nombre == 43
    end

    test "update_produits/2 with invalid data returns error changeset" do
      produits = produits_fixture()
      assert {:error, %Ecto.Changeset{}} = SuperTrucs.update_produits(produits, @invalid_attrs)
      assert produits == SuperTrucs.get_produits!(produits.id)
    end

    test "delete_produits/1 deletes the produits" do
      produits = produits_fixture()
      assert {:ok, %Produits{}} = SuperTrucs.delete_produits(produits)
      assert_raise Ecto.NoResultsError, fn -> SuperTrucs.get_produits!(produits.id) end
    end

    test "change_produits/1 returns a produits changeset" do
      produits = produits_fixture()
      assert %Ecto.Changeset{} = SuperTrucs.change_produits(produits)
    end
  end
end
