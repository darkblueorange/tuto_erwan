defmodule AdelWeb.ParkingLiveTest do
  use AdelWeb.ConnCase

  import Phoenix.LiveViewTest
  import Adel.ParkingsFixtures

  @create_attrs %{
    nom: "some nom",
    places: "some places",
    capacite: "some capacite",
    derniere_mise_a_jour_base: "some derniere_mise_a_jour_base",
    derniere_actualisation_bo: "2023-09-03T16:29:00",
    taux_doccupation: "2023-09-03T16:29:00",
    geo_point_2d: %{},
    parking_id: 42
  }
  @update_attrs %{
    nom: "some updated nom",
    places: "some updated places",
    capacite: "some updated capacite",
    derniere_mise_a_jour_base: "some updated derniere_mise_a_jour_base",
    derniere_actualisation_bo: "2023-09-04T16:29:00",
    taux_doccupation: "2023-09-04T16:29:00",
    geo_point_2d: %{},
    parking_id: 43
  }
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

  defp create_parking(_) do
    parking = parking_fixture()
    %{parking: parking}
  end

  describe "Index" do
    setup [:create_parking]

    test "lists all parkings", %{conn: conn, parking: parking} do
      {:ok, _index_live, html} = live(conn, ~p"/parkings")

      assert html =~ "Listing Parkings"
      assert html =~ parking.nom
    end

    test "saves new parking", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/parkings")

      assert index_live |> element("a", "New Parking") |> render_click() =~
               "New Parking"

      assert_patch(index_live, ~p"/parkings/new")

      assert index_live
             |> form("#parking-form", parking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#parking-form", parking: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/parkings")

      html = render(index_live)
      assert html =~ "Parking created successfully"
      assert html =~ "some nom"
    end

    test "updates parking in listing", %{conn: conn, parking: parking} do
      {:ok, index_live, _html} = live(conn, ~p"/parkings")

      assert index_live |> element("#parkings-#{parking.id} a", "Edit") |> render_click() =~
               "Edit Parking"

      assert_patch(index_live, ~p"/parkings/#{parking}/edit")

      assert index_live
             |> form("#parking-form", parking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#parking-form", parking: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/parkings")

      html = render(index_live)
      assert html =~ "Parking updated successfully"
      assert html =~ "some updated nom"
    end

    test "deletes parking in listing", %{conn: conn, parking: parking} do
      {:ok, index_live, _html} = live(conn, ~p"/parkings")

      assert index_live |> element("#parkings-#{parking.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#parkings-#{parking.id}")
    end
  end

  describe "Show" do
    setup [:create_parking]

    test "displays parking", %{conn: conn, parking: parking} do
      {:ok, _show_live, html} = live(conn, ~p"/parkings/#{parking}")

      assert html =~ "Show Parking"
      assert html =~ parking.nom
    end

    test "updates parking within modal", %{conn: conn, parking: parking} do
      {:ok, show_live, _html} = live(conn, ~p"/parkings/#{parking}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Parking"

      assert_patch(show_live, ~p"/parkings/#{parking}/show/edit")

      assert show_live
             |> form("#parking-form", parking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#parking-form", parking: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/parkings/#{parking}")

      html = render(show_live)
      assert html =~ "Parking updated successfully"
      assert html =~ "some updated nom"
    end
  end
end
