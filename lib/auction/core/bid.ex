defmodule Auction.Core.Bid do
  @moduledoc """
    Bids belong to a user and an item. When you create new items, you want an item to be owned by a user,
    and a user can own many items. Both a user and an item can have many bids.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "bids" do
    field :amount, :integer
    belongs_to :item, Auction.Core.Item
    belongs_to :user, Auction.Access.User
    timestamps()
  end

  def changeset(bid, params \\ %{}) do
    bid
    |> cast(params, [:amount, :user_id, :item_id])
    |> validate_required([:amount, :user_id, :item_id])
    |> assoc_constraint(:item)
    |> assoc_constraint(:user)
  end
end
