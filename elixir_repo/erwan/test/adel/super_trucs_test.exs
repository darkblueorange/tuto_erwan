defmodule Adel.SuperTrucsTest do
  use Adel.DataCase

  alias Adel.SuperTrucs

  describe "produits" do
    alias Adel.SuperTrucs.Produits

    import Adel.SuperTrucsFixtures

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

  describe "utilisateurs" do
    alias Adel.SuperTrucs.Utilisateurs

    import Adel.SuperTrucsFixtures

    @invalid_attrs %{prenom: nil, nom: nil, age: nil}

    test "list_utilisateurs/0 returns all utilisateurs" do
      utilisateurs = utilisateurs_fixture()
      assert SuperTrucs.list_utilisateurs() == [utilisateurs]
    end

    test "get_utilisateurs!/1 returns the utilisateurs with given id" do
      utilisateurs = utilisateurs_fixture()
      assert SuperTrucs.get_utilisateurs!(utilisateurs.id) == utilisateurs
    end

    test "create_utilisateurs/1 with valid data creates a utilisateurs" do
      valid_attrs = %{prenom: "some prenom", nom: "some nom", age: 42}

      assert {:ok, %Utilisateurs{} = utilisateurs} = SuperTrucs.create_utilisateurs(valid_attrs)
      assert utilisateurs.prenom == "some prenom"
      assert utilisateurs.nom == "some nom"
      assert utilisateurs.age == 42
    end

    test "create_utilisateurs/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SuperTrucs.create_utilisateurs(@invalid_attrs)
    end

    test "update_utilisateurs/2 with valid data updates the utilisateurs" do
      utilisateurs = utilisateurs_fixture()
      update_attrs = %{prenom: "some updated prenom", nom: "some updated nom", age: 43}

      assert {:ok, %Utilisateurs{} = utilisateurs} =
               SuperTrucs.update_utilisateurs(utilisateurs, update_attrs)

      assert utilisateurs.prenom == "some updated prenom"
      assert utilisateurs.nom == "some updated nom"
      assert utilisateurs.age == 43
    end

    test "update_utilisateurs/2 with invalid data returns error changeset" do
      utilisateurs = utilisateurs_fixture()

      assert {:error, %Ecto.Changeset{}} =
               SuperTrucs.update_utilisateurs(utilisateurs, @invalid_attrs)

      assert utilisateurs == SuperTrucs.get_utilisateurs!(utilisateurs.id)
    end

    test "delete_utilisateurs/1 deletes the utilisateurs" do
      utilisateurs = utilisateurs_fixture()
      assert {:ok, %Utilisateurs{}} = SuperTrucs.delete_utilisateurs(utilisateurs)
      assert_raise Ecto.NoResultsError, fn -> SuperTrucs.get_utilisateurs!(utilisateurs.id) end
    end

    test "change_utilisateurs/1 returns a utilisateurs changeset" do
      utilisateurs = utilisateurs_fixture()
      assert %Ecto.Changeset{} = SuperTrucs.change_utilisateurs(utilisateurs)
    end
  end
end
