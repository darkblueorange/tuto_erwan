defmodule AdelWeb.UtilisateursControllerTest do
  use AdelWeb.ConnCase

  import Adel.SuperTrucsFixtures

  @create_attrs %{prenom: "some prenom", nom: "some nom", age: 42}
  @update_attrs %{prenom: "some updated prenom", nom: "some updated nom", age: 43}
  @invalid_attrs %{prenom: nil, nom: nil, age: nil}

  describe "index" do
    test "lists all utilisateurs", %{conn: conn} do
      conn = get(conn, ~p"/utilisateurs")
      assert html_response(conn, 200) =~ "Listing Utilisateurs"
    end
  end

  describe "new utilisateurs" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/utilisateurs/new")
      assert html_response(conn, 200) =~ "New Utilisateurs"
    end
  end

  describe "create utilisateurs" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/utilisateurs", utilisateurs: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/utilisateurs/#{id}"

      conn = get(conn, ~p"/utilisateurs/#{id}")
      assert html_response(conn, 200) =~ "Utilisateurs #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/utilisateurs", utilisateurs: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Utilisateurs"
    end
  end

  describe "edit utilisateurs" do
    setup [:create_utilisateurs]

    test "renders form for editing chosen utilisateurs", %{conn: conn, utilisateurs: utilisateurs} do
      conn = get(conn, ~p"/utilisateurs/#{utilisateurs}/edit")
      assert html_response(conn, 200) =~ "Edit Utilisateurs"
    end
  end

  describe "update utilisateurs" do
    setup [:create_utilisateurs]

    test "redirects when data is valid", %{conn: conn, utilisateurs: utilisateurs} do
      conn = put(conn, ~p"/utilisateurs/#{utilisateurs}", utilisateurs: @update_attrs)
      assert redirected_to(conn) == ~p"/utilisateurs/#{utilisateurs}"

      conn = get(conn, ~p"/utilisateurs/#{utilisateurs}")
      assert html_response(conn, 200) =~ "some updated prenom"
    end

    test "renders errors when data is invalid", %{conn: conn, utilisateurs: utilisateurs} do
      conn = put(conn, ~p"/utilisateurs/#{utilisateurs}", utilisateurs: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Utilisateurs"
    end
  end

  describe "delete utilisateurs" do
    setup [:create_utilisateurs]

    test "deletes chosen utilisateurs", %{conn: conn, utilisateurs: utilisateurs} do
      conn = delete(conn, ~p"/utilisateurs/#{utilisateurs}")
      assert redirected_to(conn) == ~p"/utilisateurs"

      assert_error_sent 404, fn ->
        get(conn, ~p"/utilisateurs/#{utilisateurs}")
      end
    end
  end

  defp create_utilisateurs(_) do
    utilisateurs = utilisateurs_fixture()
    %{utilisateurs: utilisateurs}
  end
end
