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
    RSpotify.authenticate("3a6010e0d5eb491996b9b10ec5722bae", "6b4b95f225134775a2beb8de051b55b6")
    twilio = Twilio::REST::Client.new "ACd8a6cf9a41f88f8c7ccd6c07e9cd115b", "d61ef71c57656b1c4f724d8d697a1f4e"

    artist = RSpotify::Artist.search(artist).first
    track = artist.top_tracks(:US).first

    twilio.messages.create(
      body: "#{artist.name}'s top track: #{track.name}",
      from: "+19785755492",
      to: phone_number
    )
  end
end
