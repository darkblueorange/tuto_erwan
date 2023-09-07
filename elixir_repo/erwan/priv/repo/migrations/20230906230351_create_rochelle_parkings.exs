defmodule Adel.Repo.Migrations.CreateRochelleParkings do
  use Ecto.Migration

  def change do
    create table(:rochelle_parkings) do
      add :nb_places, :integer
      add :nb_autopartage, :integer
      add :nb_velo, :integer
      add :nb_velo_dispo, :integer
      add :nb_2r_el_dispo, :integer
      add :parking_string_id, :string
      add :ylat, :float
      add :nb_2_rm, :integer
      add :nb_2_rm_dispo, :integer
      add :nb_2r_el, :integer
      add :xlong, :float
      add :nom, :string
      add :nb_voitures_electriques, :integer
      add :nb_places_disponibles, :integer
      add :nb_pr_dispo, :integer
      add :nb_pmr, :integer
      add :coord_y, :float
      add :coord_x, :float
      add :nb_voitures_electriques_dispo, :integer
      add :total_count, :integer
      add :full_binary_text, :text
      add :nb_pmr_dispo, :integer
      add :nb_pr, :integer
      add :other_id, :integer
      add :nb_autopartage_dispo, :integer
      add :date_comptage, :naive_datetime

      timestamps()
    end
  end
end
