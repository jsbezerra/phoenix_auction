defmodule Auction.Access.User do
  @moduledoc """
    Defines the user for Authentication and Authorization.
  """

  alias Auction.Access.Password
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email_address, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    has_many :bids, Auction.Core.Bid
    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:username, :email_address])
    |> validate_required([:username, :email_address, :hashed_password])
    |> validate_length(:username, min: 5)
    |> unique_constraint(:username)
  end

  def changeset_with_password(user, params \\ %{}) do
    user
    |> cast(params, [:password])
    |> validate_required(:password)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, required: true)
    |> hash_password()
    |> changeset(params)
  end

  defp hash_password(%Ecto.Changeset{changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:hashed_password, Password.hash(password))
  end

  defp hash_password(changeset), do: changeset
end
