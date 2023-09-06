defmodule Erwan.Parkings do
  @moduledoc """
  The Parkings context.
  """

  import Ecto.Query, warn: false
  alias Erwan.Repo

  alias Erwan.Parkings.Parking

  @doc """
  Returns the list of parkings.

  ## Examples

      iex> list_parkings()
      [%Parking{}, ...]

  """
  def list_parkings do
    Parking
    |> order_by([p], desc: p.derniere_actualisation_bo)
    |> Repo.all()
  end

  def list_parkings_reduced() do
    Parking
    |> select([p], {p.nom, p.nom})
    |> distinct(true)
    |> Repo.all()
  end

  def list_parkings("Tous les parkings") do
    Parking
    |> order_by([p], desc: p.derniere_actualisation_bo)
    |> Repo.all()
  end

  def list_parkings(parking_name) when parking_name |> is_binary() do
    Parking
    |> where([p], p.nom == ^parking_name)
    |> order_by([p], desc: p.derniere_actualisation_bo)
    |> Repo.all()
  end

  def list_parkings_vega(parking_name) when parking_name |> is_binary() do
    Parking
    |> select([p], %{
      places: p.places,
      taux_doccupation: p.taux_doccupation,
      # derniere_mise_a_jour_base: p.derniere_mise_a_jour_base
      "Base temps réel": p.derniere_mise_a_jour_base
    })
    |> where([p], p.nom == ^parking_name)
    |> order_by([p], desc: p.derniere_actualisation_bo)
    |> Repo.all()
  end

  # This function is not correct because timing is not so precise
  # We should do a window sort of sum to be able to "adjust" timing of update of each parking
  # Or maybe extrapolate. Too difficult for now
  def list_parkings_and_sum() do
    Parking
    |> group_by([p], [p.derniere_mise_a_jour_base])
    |> select([p], %{
      places: sum(p.places),
      derniere_mise_a_jour_base: p.derniere_mise_a_jour_base
    })
    |> Repo.all()
  end

  @doc """
  Gets a single parking.

  Raises `Ecto.NoResultsError` if the Parking does not exist.

  ## Examples

      iex> get_parking!(123)
      %Parking{}

      iex> get_parking!(456)
      ** (Ecto.NoResultsError)

  """
  def get_parking!(id), do: Repo.get!(Parking, id)

  @doc """
  Creates a parking.

  ## Examples

      iex> create_parking(%{field: value})
      {:ok, %Parking{}}

      iex> create_parking(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_parking(attrs \\ %{}) do
    %Parking{}
    |> Parking.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a parking.

  ## Examples

      iex> update_parking(parking, %{field: new_value})
      {:ok, %Parking{}}

      iex> update_parking(parking, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_parking(%Parking{} = parking, attrs) do
    parking
    |> Parking.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a parking.

  ## Examples

      iex> delete_parking(parking)
      {:ok, %Parking{}}

      iex> delete_parking(parking)
      {:error, %Ecto.Changeset{}}

  """
  def delete_parking(%Parking{} = parking) do
    Repo.delete(parking)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking parking changes.

  ## Examples

      iex> change_parking(parking)
      %Ecto.Changeset{data: %Parking{}}

  """
  def change_parking(%Parking{} = parking, attrs \\ %{}) do
    Parking.changeset(parking, attrs)
  end
end
