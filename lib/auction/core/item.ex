defmodule Auction.Core.Item do
  @moduledoc """
    Represents the data for the different things to be auctioned.
  """
  defstruct [:id, :title, :description, :ends_at]
end
