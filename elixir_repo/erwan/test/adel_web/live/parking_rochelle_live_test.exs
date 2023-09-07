defmodule AdelWeb.ParkingRochelleLiveTest do
  use AdelWeb.ConnCase

  import Phoenix.LiveViewTest
  import Adel.ParkingsFixtures

  @create_attrs %{
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
    date_comptage: "2023-09-05T23:03:00"
  }
  @update_attrs %{
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
    date_comptage: "2023-09-06T23:03:00"
  }
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

  defp create_parking_rochelle(_) do
    parking_rochelle = parking_rochelle_fixture()
    %{parking_rochelle: parking_rochelle}
  end

  describe "Index" do
    setup [:create_parking_rochelle]

    test "lists all rochelle_parkings", %{conn: conn, parking_rochelle: parking_rochelle} do
      {:ok, _index_live, html} = live(conn, ~p"/rochelle_parkings")

      assert html =~ "Listing Rochelle parkings"
      assert html =~ parking_rochelle.parking_string_id
    end

    test "saves new parking_rochelle", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/rochelle_parkings")

      assert index_live |> element("a", "New Parking rochelle") |> render_click() =~
               "New Parking rochelle"

      assert_patch(index_live, ~p"/rochelle_parkings/new")

      assert index_live
             |> form("#parking_rochelle-form", parking_rochelle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#parking_rochelle-form", parking_rochelle: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/rochelle_parkings")

      html = render(index_live)
      assert html =~ "Parking rochelle created successfully"
      assert html =~ "some parking_string_id"
    end

    test "updates parking_rochelle in listing", %{conn: conn, parking_rochelle: parking_rochelle} do
      {:ok, index_live, _html} = live(conn, ~p"/rochelle_parkings")

      assert index_live
             |> element("#rochelle_parkings-#{parking_rochelle.id} a", "Edit")
             |> render_click() =~
               "Edit Parking rochelle"

      assert_patch(index_live, ~p"/rochelle_parkings/#{parking_rochelle}/edit")

      assert index_live
             |> form("#parking_rochelle-form", parking_rochelle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#parking_rochelle-form", parking_rochelle: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/rochelle_parkings")

      html = render(index_live)
      assert html =~ "Parking rochelle updated successfully"
      assert html =~ "some updated parking_string_id"
    end

    test "deletes parking_rochelle in listing", %{conn: conn, parking_rochelle: parking_rochelle} do
      {:ok, index_live, _html} = live(conn, ~p"/rochelle_parkings")

      assert index_live
             |> element("#rochelle_parkings-#{parking_rochelle.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#rochelle_parkings-#{parking_rochelle.id}")
    end
  end

  describe "Show" do
    setup [:create_parking_rochelle]

    test "displays parking_rochelle", %{conn: conn, parking_rochelle: parking_rochelle} do
      {:ok, _show_live, html} = live(conn, ~p"/rochelle_parkings/#{parking_rochelle}")

      assert html =~ "Show Parking rochelle"
      assert html =~ parking_rochelle.parking_string_id
    end

    test "updates parking_rochelle within modal", %{
      conn: conn,
      parking_rochelle: parking_rochelle
    } do
      {:ok, show_live, _html} = live(conn, ~p"/rochelle_parkings/#{parking_rochelle}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Parking rochelle"

      assert_patch(show_live, ~p"/rochelle_parkings/#{parking_rochelle}/show/edit")

      assert show_live
             |> form("#parking_rochelle-form", parking_rochelle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#parking_rochelle-form", parking_rochelle: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/rochelle_parkings/#{parking_rochelle}")

      html = render(show_live)
      assert html =~ "Parking rochelle updated successfully"
      assert html =~ "some updated parking_string_id"
    end
  end
end
