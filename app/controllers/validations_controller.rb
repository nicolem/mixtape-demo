# frozen_string_literal: true

class ValidationsController < ApplicationController
  include Notifiable

  def create
    if notification.valid?
      render json: {}, status: :ok
    else
      render json: { errors: notification.error_messages }, status: :unprocessable_entity
    end
  end
end
