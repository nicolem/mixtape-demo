require 'rails_helper'
RSpec.describe NotificationJob do
  subject { described_class.new }
  let(:valid_phone) { "+15005550006" }
  let(:valid_artist) { "Modest Mouse" }

  let(:invalid_phone) { "+150" }
  let(:invalid_artist) { SecureRandom.uuid }

  context 'when given no arguments' do
    it 'returns argument error' do
      expect{
        subject.perform()
      }.to raise_error(
        ArgumentError
      )
    end
  end

  context 'when given valid artist and phone number' do
    it 'returns a successful twilio result' do
      result = subject.perform(valid_artist, valid_phone)
      expect(result[:error_message]).to eq(nil)
      expect(result[:status]).to eq("queued")
      expect(result[:to]).to eq(valid_phone)
      expect(result[:body]).to match(/#{valid_artist}/)
    end
  end

  context 'when given valid artist and invalid phone number' do
    it 'returns invalid phone error from twilio' do
      allow(Rails.logger).to receive(:error)

      result = subject.perform(valid_artist, invalid_phone)
      expect(result[:error_message]).to eq("The 'To' number XXXX is not a valid phone number")
      expect(result[:status]).to eq(400)
      expect(Rails.logger).to have_received(:error).with(match(/not a valid phone number/))
    end
  end

  context 'when given invalid artist' do
    it 'returns no artist error' do
      allow(Rails.logger).to receive(:error)

      result = subject.perform(invalid_artist, valid_phone)
      expect(result[:error_message]).to eq("Artist not found")
      expect(Rails.logger).to have_received(:error).with("Artist not found")
    end
  end
end