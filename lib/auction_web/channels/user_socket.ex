defmodule AuctionWeb.UserSocket do
  use Phoenix.Socket

  channel "item:*", AuctionWeb.ItemChannel

  def connect(%{"token" => token}, socket) do
    {:ok, assign(socket, :token, token)}
  end

  def id(socket) do
    "user_socket:#{socket.assigns.token}"
  end
end
