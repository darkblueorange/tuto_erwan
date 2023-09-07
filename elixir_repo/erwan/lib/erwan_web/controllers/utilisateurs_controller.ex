defmodule AdelWeb.UtilisateursController do
  use AdelWeb, :controller

  alias Adel.SuperTrucs
  alias Adel.SuperTrucs.Utilisateurs

  def index(conn, _params) do
    utilisateurs =
      SuperTrucs.list_utilisateurs()

    render(conn, :index, utilisateurs: utilisateurs)
  end

  def new(conn, _params) do
    changeset = SuperTrucs.change_utilisateurs(%Utilisateurs{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"utilisateurs" => utilisateurs_params}) do
    case SuperTrucs.create_utilisateurs(utilisateurs_params) do
      {:ok, utilisateurs} ->
        conn
        |> put_flash(:info, "Utilisateurs created successfully.")
        |> redirect(to: ~p"/utilisateurs/#{utilisateurs}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    utilisateurs = SuperTrucs.get_utilisateurs!(id)
    render(conn, :show, utilisateurs: utilisateurs)
  end

  def edit(conn, %{"id" => id}) do
    utilisateurs = SuperTrucs.get_utilisateurs!(id)
    changeset = SuperTrucs.change_utilisateurs(utilisateurs)
    render(conn, :edit, utilisateurs: utilisateurs, changeset: changeset)
  end

  def update(conn, %{"id" => id, "utilisateurs" => utilisateurs_params}) do
    utilisateurs = SuperTrucs.get_utilisateurs!(id)

    case SuperTrucs.update_utilisateurs(utilisateurs, utilisateurs_params) do
      {:ok, utilisateurs} ->
        conn
        |> put_flash(:info, "Utilisateurs updated successfully.")
        |> redirect(to: ~p"/utilisateurs/#{utilisateurs}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, utilisateurs: utilisateurs, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    utilisateurs = SuperTrucs.get_utilisateurs!(id)
    {:ok, _utilisateurs} = SuperTrucs.delete_utilisateurs(utilisateurs)

    conn
    |> put_flash(:info, "Utilisateurs deleted successfully.")
    |> redirect(to: ~p"/utilisateurs")
  end
end
