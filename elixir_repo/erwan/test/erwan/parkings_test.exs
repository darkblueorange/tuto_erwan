defmodule Erwan.ParkingsTest do
  use Erwan.DataCase

  alias Erwan.Parkings

  describe "parkings" do
    alias Erwan.Parkings.Parking

    import Erwan.ParkingsFixtures

    @invalid_attrs %{nom: nil, places: nil, capacite: nil, derniere_mise_a_jour_base: nil, derniere_actualisation_bo: nil, taux_doccupation: nil, geo_point_2d: nil, parking_id: nil}

    test "list_parkings/0 returns all parkings" do
      parking = parking_fixture()
      assert Parkings.list_parkings() == [parking]
    end

    test "get_parking!/1 returns the parking with given id" do
      parking = parking_fixture()
      assert Parkings.get_parking!(parking.id) == parking
    end

    test "create_parking/1 with valid data creates a parking" do
      valid_attrs = %{nom: "some nom", places: "some places", capacite: "some capacite", derniere_mise_a_jour_base: "some derniere_mise_a_jour_base", derniere_actualisation_bo: ~N[2023-09-03 16:29:00], taux_doccupation: ~N[2023-09-03 16:29:00], geo_point_2d: %{}, parking_id: 42}

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
      update_attrs = %{nom: "some updated nom", places: "some updated places", capacite: "some updated capacite", derniere_mise_a_jour_base: "some updated derniere_mise_a_jour_base", derniere_actualisation_bo: ~N[2023-09-04 16:29:00], taux_doccupation: ~N[2023-09-04 16:29:00], geo_point_2d: %{}, parking_id: 43}

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
end
