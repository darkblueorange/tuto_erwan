defmodule Erwan.Repo.Migrations.CreateParkings do
  use Ecto.Migration

  def change do
    create table(:parkings) do
      add :nom, :string
      add :places, :string
      add :capacite, :string
      add :derniere_mise_a_jour_base, :string
      add :derniere_actualisation_bo, :naive_datetime
      add :taux_doccupation, :naive_datetime
      add :geo_point_2d, :map
      add :parking_id, :integer

      timestamps()
    end
  end
end
