defmodule AdelWeb.ProduitsLiveTest do
  use AdelWeb.ConnCase

  import Phoenix.LiveViewTest
  import Adel.SuperTrucsFixtures

  @create_attrs %{nom: "some nom", categorie: "some categorie", nombre: 42}
  @update_attrs %{nom: "some updated nom", categorie: "some updated categorie", nombre: 43}
  @invalid_attrs %{nom: nil, categorie: nil, nombre: nil}

  defp create_produits(_) do
    produits = produits_fixture()
    %{produits: produits}
  end

  describe "Index" do
    setup [:create_produits]

    test "lists all produits", %{conn: conn, produits: produits} do
      {:ok, _index_live, html} = live(conn, ~p"/produits")

      assert html =~ "Listing Produits"
      assert html =~ produits.nom
    end

    test "saves new produits", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/produits")

      assert index_live |> element("a", "New Produits") |> render_click() =~
               "New Produits"

      assert_patch(index_live, ~p"/produits/new")

      assert index_live
             |> form("#produits-form", produits: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#produits-form", produits: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/produits")

      html = render(index_live)
      assert html =~ "Produits created successfully"
      assert html =~ "some nom"
    end

    test "updates produits in listing", %{conn: conn, produits: produits} do
      {:ok, index_live, _html} = live(conn, ~p"/produits")

      assert index_live |> element("#produits-#{produits.id} a", "Edit") |> render_click() =~
               "Edit Produits"

      assert_patch(index_live, ~p"/produits/#{produits}/edit")

      assert index_live
             |> form("#produits-form", produits: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#produits-form", produits: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/produits")

      html = render(index_live)
      assert html =~ "Produits updated successfully"
      assert html =~ "some updated nom"
    end

    test "deletes produits in listing", %{conn: conn, produits: produits} do
      {:ok, index_live, _html} = live(conn, ~p"/produits")

      assert index_live |> element("#produits-#{produits.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#produits-#{produits.id}")
    end
  end

  describe "Show" do
    setup [:create_produits]

    test "displays produits", %{conn: conn, produits: produits} do
      {:ok, _show_live, html} = live(conn, ~p"/produits/#{produits}")

      assert html =~ "Show Produits"
      assert html =~ produits.nom
    end

    test "updates produits within modal", %{conn: conn, produits: produits} do
      {:ok, show_live, _html} = live(conn, ~p"/produits/#{produits}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Produits"

      assert_patch(show_live, ~p"/produits/#{produits}/show/edit")

      assert show_live
             |> form("#produits-form", produits: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#produits-form", produits: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/produits/#{produits}")

      html = render(show_live)
      assert html =~ "Produits updated successfully"
      assert html =~ "some updated nom"
    end
  end
end
