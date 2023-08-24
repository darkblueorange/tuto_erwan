defmodule Erwan.SuperTrucs do
  @moduledoc """
  The SuperTrucs context.
  """

  import Ecto.Query, warn: false
  alias Erwan.Repo

  alias Erwan.SuperTrucs.Produits

  @doc """
  Returns the list of produits.

  ## Examples

      iex> list_produits()
      [%Produits{}, ...]

  """
  def list_produits do
    Repo.all(Produits)
  end

  @doc """
  Gets a single produits.

  Raises `Ecto.NoResultsError` if the Produits does not exist.

  ## Examples

      iex> get_produits!(123)
      %Produits{}

      iex> get_produits!(456)
      ** (Ecto.NoResultsError)

  """
  def get_produits!(id), do: Repo.get!(Produits, id)

  @doc """
  Creates a produits.

  ## Examples

      iex> create_produits(%{field: value})
      {:ok, %Produits{}}

      iex> create_produits(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_produits(attrs \\ %{}) do
    %Produits{}
    |> Produits.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a produits.

  ## Examples

      iex> update_produits(produits, %{field: new_value})
      {:ok, %Produits{}}

      iex> update_produits(produits, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_produits(%Produits{} = produits, attrs) do
    produits
    |> Produits.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a produits.

  ## Examples

      iex> delete_produits(produits)
      {:ok, %Produits{}}

      iex> delete_produits(produits)
      {:error, %Ecto.Changeset{}}

  """
  def delete_produits(%Produits{} = produits) do
    Repo.delete(produits)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking produits changes.

  ## Examples

      iex> change_produits(produits)
      %Ecto.Changeset{data: %Produits{}}

  """
  def change_produits(%Produits{} = produits, attrs \\ %{}) do
    Produits.changeset(produits, attrs)
  end
end
