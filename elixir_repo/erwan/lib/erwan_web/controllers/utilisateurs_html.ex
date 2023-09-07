defmodule AdelWeb.UtilisateursHTML do
  use AdelWeb, :html

  embed_templates "utilisateurs_html/*"

  @doc """
  Renders a utilisateurs form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def utilisateurs_form(assigns)
end
