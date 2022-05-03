defmodule Auction.Core.Item do
  @moduledoc """
    Represents the data for the different things to be auctioned.
  """

  use Ecto.Schema

  schema "items" do
    field :title, :string
    field :description, :string
    field :ends_at, :utc_datetime
    timestamps()
  end
end
