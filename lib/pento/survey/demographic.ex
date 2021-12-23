defmodule Pento.Survey.Demographic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pento.Accounts.User

  schema "demographics" do
    field :sex, :string
    field :year_of_birth, :integer
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(demographic, attrs) do
    demographic
    |> cast(attrs, [:sex, :year_of_birth, :user_id])
    |> validate_required([:sex, :year_of_birth, :user_id])
    |> validate_inclusion(
      :sex,
      ["male", "female"]
    )
    |> validate_inclusion(:year_of_birth, 1900..Date.utc_today().year)
    |> unique_constraint(:user_id)
  end
end
