defmodule Adel.Repo.Migrations.CreateUtilisateurs do
  use Ecto.Migration

  def change do
    create table(:utilisateurs) do
      add :prenom, :string
      add :nom, :string
      add :age, :integer

      timestamps()
    end
  end
end
