# frozen_string_literal: true

module Notifiable
  extend ActiveSupport::Concern

  private

  def notification
    @notification ||= Notification.new(
      artist: notification_params[:artist],
      phone_number: notification_params[:phoneNumber]
    )
  end

  def notification_params
    params.require(:notification).permit(:artist, :phoneNumber)
  end
end
