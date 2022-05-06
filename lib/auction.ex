defmodule Auction do
  @moduledoc """
  Auction keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Auction.Access.{Password, User}
  alias Auction.Core.{Bid, Item}
  alias Auction.Repo

  @repo Repo

  def list_items do
    @repo.all(Item)
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  def get_item_with_bids(id) do
    id
    |> get_item()
    |> @repo.preload(bids: [:user])
  end

  def insert_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> @repo.insert()
  end

  def edit_item(id) do
    get_item(id)
    |> Item.changeset()
  end

  def update_item(%Item{} = item, updates) do
    item
    |> Item.changeset(updates)
    |> @repo.update()
  end

  def new_item, do: Item.changeset(%Item{})

  def delete_item(%Item{} = item), do: @repo.delete(item)

  def get_user(id), do: @repo.get!(User, id)

  def new_user, do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> @repo.insert
  end

  def get_user_by_username_and_password(username, password) do
    with user when not is_nil(user) <- @repo.get_by(User, %{username: username}),
         true <- Password.verify_with_hash(password, user.hashed_password) do
      user
    else
      _ -> Password.dummy_verify()
    end
  end

  def new_bid, do: Bid.changeset(%Bid{})

  def insert_bid(params) do
    %Bid{}
    |> Bid.changeset(params)
    |> @repo.insert()
  end
end
