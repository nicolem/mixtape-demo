# frozen_string_literal: true

# Note: 2023-10-11 issue with Twilio messages arriving
#
# To USA phone numbers (+1 dial code, but Canada not affected):
# At the moment, we are having issues with SMS messages arriving to
# phone numbers in the USA. This is due to some new registration
# requirements with Twilio that we need to go through. The registration process
# takes some time to complete, so for the moment, SMS messages may not arrive.
#
# To phone numbers outside the USA:
# For some countries, you may receive an error from Twilio with the code "21408"
# and a message stating that we're not registered for sending to that region.
#
# In either of these cases, you can use Twilio's test phone number +15005550006. If you receive a response
# from Twilio with the status of "queued", and you do not receive an exception, you can assume that
# your sending code is working, and that the SMS would send correctly.
#
# For example, with NotificationJob in its given state:
#
# result = NotificationJob.new.perform("Modest Mouse", "+15005550006")
# result.status
# => "queued"
# result.error_message
# => nil
class NotificationJob
  include Sidekiq::Job

  def perform(artist, phone_number)
    begin
      song_lookup(artist)
      send_text(phone_number)
    rescue Twilio::REST::RestError => e
      Rails.logger.error e.message
      return formatted_response(e)
    rescue ArgumentError => e
      Rails.logger.error e.message
      return formatted_response(e)
    end
  end

  private

  def song_lookup(artist)
    RSpotify.authenticate(
      Rails.application.credentials.spotify[:client_id],
      Rails.application.credentials.spotify[:client_secret]
    )
    @artist = RSpotify::Artist.search(artist).first
    raise ArgumentError, "Artist not found" unless @artist

    @track = @artist.top_tracks(:US).first
    raise ArgumentError, "Artist missing Top Tracks" unless @track
  end

  def send_text(phone_number)
    twilio = Twilio::REST::Client.new(
      Rails.application.credentials.twilio[:account_sid],
      Rails.application.credentials.twilio[:auth_token]
    )
    twilio_response = twilio.messages.create(
      body: "#{@artist.name}'s top track: #{@track.name}",
      from: "+19785755492",
      to: phone_number
    )

    formatted_response(twilio_response)
  end

  def formatted_response(args)
    {
      error_message: args.try(:error_message) || args.try(:message),
      status: args.try(:status) || args.try(:status_code),
      to: args.try(:to),
      body: args.try(:body)
    }
  end
end
