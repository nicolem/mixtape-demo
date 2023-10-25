# frozen_string_literal: true

class NotificationsController < ApplicationController
  include Notifiable

  def create
    if notification.create
      render json: {}, status: :ok
    else
      render json: { errors: notification.error_messages }, status: :unprocessable_entity
    end
  end
end
