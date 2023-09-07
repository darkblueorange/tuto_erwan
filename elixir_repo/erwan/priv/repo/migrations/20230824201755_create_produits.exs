defmodule Adel.Repo.Migrations.CreateProduits do
  use Ecto.Migration

  def change do
    create table(:produits) do
      add :nom, :string
      add :categorie, :string
      add :nombre, :integer

      timestamps()
    end
  end
end
