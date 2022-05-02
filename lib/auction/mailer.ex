defmodule Auction.Mailer do
  @moduledoc """
    Provides mailing capabilities to the project.
  """
  use Swoosh.Mailer, otp_app: :auction
end
