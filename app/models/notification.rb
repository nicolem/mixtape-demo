# frozen_string_literal: true

class Notification
  PHONE_REGEX = /\A(\+)?\d+\z/.freeze

  include ActiveModel::Validations

  attr_reader :artist, :phone_number

  validates :artist, presence: true
  validates :phone_number, presence: true
  validates :phone_number, format: { with: PHONE_REGEX, message: "invalid format" }

  def initialize(artist:, phone_number:)
    @artist = artist
    @phone_number = phone_number

    valid?
  end

  def create
    return false unless valid?

    NotificationJob.perform_async(
      artist,
      phone_number
    )

    true
  end

  def error_messages
    errors.messages
  end
end
