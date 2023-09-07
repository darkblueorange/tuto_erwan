defmodule Adel.ParkingsTest do
  use Adel.DataCase

  alias Adel.Parkings

  describe "parkings" do
    alias Adel.Parkings.Parking

    import Adel.ParkingsFixtures

    @invalid_attrs %{
      nom: nil,
      places: nil,
      capacite: nil,
      derniere_mise_a_jour_base: nil,
      derniere_actualisation_bo: nil,
      taux_doccupation: nil,
      geo_point_2d: nil,
      parking_id: nil
    }

    test "list_parkings/0 returns all parkings" do
      parking = parking_fixture()
      assert Parkings.list_parkings() == [parking]
    end

    test "get_parking!/1 returns the parking with given id" do
      parking = parking_fixture()
      assert Parkings.get_parking!(parking.id) == parking
    end

    test "create_parking/1 with valid data creates a parking" do
      valid_attrs = %{
        nom: "some nom",
        places: "some places",
        capacite: "some capacite",
        derniere_mise_a_jour_base: "some derniere_mise_a_jour_base",
        derniere_actualisation_bo: ~N[2023-09-03 16:29:00],
        taux_doccupation: ~N[2023-09-03 16:29:00],
        geo_point_2d: %{},
        parking_id: 42
      }

      assert {:ok, %Parking{} = parking} = Parkings.create_parking(valid_attrs)
      assert parking.nom == "some nom"
      assert parking.places == "some places"
      assert parking.capacite == "some capacite"
      assert parking.derniere_mise_a_jour_base == "some derniere_mise_a_jour_base"
      assert parking.derniere_actualisation_bo == ~N[2023-09-03 16:29:00]
      assert parking.taux_doccupation == ~N[2023-09-03 16:29:00]
      assert parking.geo_point_2d == %{}
      assert parking.parking_id == 42
    end

    test "create_parking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parkings.create_parking(@invalid_attrs)
    end

    test "update_parking/2 with valid data updates the parking" do
      parking = parking_fixture()

      update_attrs = %{
        nom: "some updated nom",
        places: "some updated places",
        capacite: "some updated capacite",
        derniere_mise_a_jour_base: "some updated derniere_mise_a_jour_base",
        derniere_actualisation_bo: ~N[2023-09-04 16:29:00],
        taux_doccupation: ~N[2023-09-04 16:29:00],
        geo_point_2d: %{},
        parking_id: 43
      }

      assert {:ok, %Parking{} = parking} = Parkings.update_parking(parking, update_attrs)
      assert parking.nom == "some updated nom"
      assert parking.places == "some updated places"
      assert parking.capacite == "some updated capacite"
      assert parking.derniere_mise_a_jour_base == "some updated derniere_mise_a_jour_base"
      assert parking.derniere_actualisation_bo == ~N[2023-09-04 16:29:00]
      assert parking.taux_doccupation == ~N[2023-09-04 16:29:00]
      assert parking.geo_point_2d == %{}
      assert parking.parking_id == 43
    end

    test "update_parking/2 with invalid data returns error changeset" do
      parking = parking_fixture()
      assert {:error, %Ecto.Changeset{}} = Parkings.update_parking(parking, @invalid_attrs)
      assert parking == Parkings.get_parking!(parking.id)
    end

    test "delete_parking/1 deletes the parking" do
      parking = parking_fixture()
      assert {:ok, %Parking{}} = Parkings.delete_parking(parking)
      assert_raise Ecto.NoResultsError, fn -> Parkings.get_parking!(parking.id) end
    end

    test "change_parking/1 returns a parking changeset" do
      parking = parking_fixture()
      assert %Ecto.Changeset{} = Parkings.change_parking(parking)
    end
  end

  describe "rochelle_parkings" do
    alias Adel.Parkings.ParkingRochelle

    import Adel.ParkingsFixtures

    @invalid_attrs %{
      nb_places: nil,
      nb_autopartage: nil,
      nb_velo: nil,
      nb_velo_dispo: nil,
      nb_2r_el_dispo: nil,
      parking_string_id: nil,
      ylat: nil,
      nb_2_rm: nil,
      nb_2_rm_dispo: nil,
      nb_2r_el: nil,
      xlong: nil,
      nom: nil,
      nb_voitures_electriques: nil,
      nb_places_disponibles: nil,
      nb_pr_dispo: nil,
      nb_pmr: nil,
      coord_y: nil,
      coord_x: nil,
      nb_voitures_electriques_dispo: nil,
      total_count: nil,
      full_binary_text: nil,
      nb_pmr_dispo: nil,
      nb_pr: nil,
      other_id: nil,
      nb_autopartage_dispo: nil,
      date_comptage: nil
    }

    test "list_rochelle_parkings/0 returns all rochelle_parkings" do
      parking_rochelle = parking_rochelle_fixture()
      assert Parkings.list_rochelle_parkings() == [parking_rochelle]
    end

    test "get_parking_rochelle!/1 returns the parking_rochelle with given id" do
      parking_rochelle = parking_rochelle_fixture()
      assert Parkings.get_parking_rochelle!(parking_rochelle.id) == parking_rochelle
    end

    test "create_parking_rochelle/1 with valid data creates a parking_rochelle" do
      valid_attrs = %{
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
      }

      assert {:ok, %ParkingRochelle{} = parking_rochelle} =
               Parkings.create_parking_rochelle(valid_attrs)

      assert parking_rochelle.nb_places == 42
      assert parking_rochelle.nb_autopartage == 42
      assert parking_rochelle.nb_velo == 42
      assert parking_rochelle.nb_velo_dispo == 42
      assert parking_rochelle.nb_2r_el_dispo == 42
      assert parking_rochelle.parking_string_id == "some parking_string_id"
      assert parking_rochelle.ylat == 120.5
      assert parking_rochelle.nb_2_rm == 42
      assert parking_rochelle.nb_2_rm_dispo == 42
      assert parking_rochelle.nb_2r_el == 42
      assert parking_rochelle.xlong == 120.5
      assert parking_rochelle.nom == "some nom"
      assert parking_rochelle.nb_voitures_electriques == 42
      assert parking_rochelle.nb_places_disponibles == 42
      assert parking_rochelle.nb_pr_dispo == 42
      assert parking_rochelle.nb_pmr == 42
      assert parking_rochelle.coord_y == 120.5
      assert parking_rochelle.coord_x == 120.5
      assert parking_rochelle.nb_voitures_electriques_dispo == 42
      assert parking_rochelle.total_count == 42
      assert parking_rochelle.full_binary_text == "some full_binary_text"
      assert parking_rochelle.nb_pmr_dispo == 42
      assert parking_rochelle.nb_pr == 42
      assert parking_rochelle.other_id == 42
      assert parking_rochelle.nb_autopartage_dispo == 42
      assert parking_rochelle.date_comptage == ~N[2023-09-05 23:03:00]
    end

    test "create_parking_rochelle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parkings.create_parking_rochelle(@invalid_attrs)
    end

    test "update_parking_rochelle/2 with valid data updates the parking_rochelle" do
      parking_rochelle = parking_rochelle_fixture()

      update_attrs = %{
        nb_places: 43,
        nb_autopartage: 43,
        nb_velo: 43,
        nb_velo_dispo: 43,
        nb_2r_el_dispo: 43,
        parking_string_id: "some updated parking_string_id",
        ylat: 456.7,
        nb_2_rm: 43,
        nb_2_rm_dispo: 43,
        nb_2r_el: 43,
        xlong: 456.7,
        nom: "some updated nom",
        nb_voitures_electriques: 43,
        nb_places_disponibles: 43,
        nb_pr_dispo: 43,
        nb_pmr: 43,
        coord_y: 456.7,
        coord_x: 456.7,
        nb_voitures_electriques_dispo: 43,
        total_count: 43,
        full_binary_text: "some updated full_binary_text",
        nb_pmr_dispo: 43,
        nb_pr: 43,
        other_id: 43,
        nb_autopartage_dispo: 43,
        date_comptage: ~N[2023-09-06 23:03:00]
      }

      assert {:ok, %ParkingRochelle{} = parking_rochelle} =
               Parkings.update_parking_rochelle(parking_rochelle, update_attrs)

      assert parking_rochelle.nb_places == 43
      assert parking_rochelle.nb_autopartage == 43
      assert parking_rochelle.nb_velo == 43
      assert parking_rochelle.nb_velo_dispo == 43
      assert parking_rochelle.nb_2r_el_dispo == 43
      assert parking_rochelle.parking_string_id == "some updated parking_string_id"
      assert parking_rochelle.ylat == 456.7
      assert parking_rochelle.nb_2_rm == 43
      assert parking_rochelle.nb_2_rm_dispo == 43
      assert parking_rochelle.nb_2r_el == 43
      assert parking_rochelle.xlong == 456.7
      assert parking_rochelle.nom == "some updated nom"
      assert parking_rochelle.nb_voitures_electriques == 43
      assert parking_rochelle.nb_places_disponibles == 43
      assert parking_rochelle.nb_pr_dispo == 43
      assert parking_rochelle.nb_pmr == 43
      assert parking_rochelle.coord_y == 456.7
      assert parking_rochelle.coord_x == 456.7
      assert parking_rochelle.nb_voitures_electriques_dispo == 43
      assert parking_rochelle.total_count == 43
      assert parking_rochelle.full_binary_text == "some updated full_binary_text"
      assert parking_rochelle.nb_pmr_dispo == 43
      assert parking_rochelle.nb_pr == 43
      assert parking_rochelle.other_id == 43
      assert parking_rochelle.nb_autopartage_dispo == 43
      assert parking_rochelle.date_comptage == ~N[2023-09-06 23:03:00]
    end

    test "update_parking_rochelle/2 with invalid data returns error changeset" do
      parking_rochelle = parking_rochelle_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Parkings.update_parking_rochelle(parking_rochelle, @invalid_attrs)

      assert parking_rochelle == Parkings.get_parking_rochelle!(parking_rochelle.id)
    end

    test "delete_parking_rochelle/1 deletes the parking_rochelle" do
      parking_rochelle = parking_rochelle_fixture()
      assert {:ok, %ParkingRochelle{}} = Parkings.delete_parking_rochelle(parking_rochelle)

      assert_raise Ecto.NoResultsError, fn ->
        Parkings.get_parking_rochelle!(parking_rochelle.id)
      end
    end

    test "change_parking_rochelle/1 returns a parking_rochelle changeset" do
      parking_rochelle = parking_rochelle_fixture()
      assert %Ecto.Changeset{} = Parkings.change_parking_rochelle(parking_rochelle)
    end
  end
end
