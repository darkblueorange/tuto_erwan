defmodule Adel.Repo.Migrations.CreateParkings do
  use Ecto.Migration

  def change do
    create table(:parkings) do
      add :nom, :string
      add :places, :integer
      add :capacite, :integer
      add :derniere_mise_a_jour_base, :naive_datetime
      add :derniere_actualisation_bo, :naive_datetime
      add :taux_doccupation, :float
      add :geo_point_2d, :map
      add :parking_id, :integer

      timestamps()
    end
  end
end
