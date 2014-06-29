class Suggestion < ActiveRecord::Base
  after_create :update_subscribers

  belongs_to :user
  belongs_to :meal

  def update_subscribers
    create_jawbone_custom_event
    create_twilio_message
  end

  private

  def jawbone_client
    @jawbone_client ||= Jawbone::Client.new(user.jawbone_access_token)
  end

  def create_jawbone_custom_event
    jawbone_client.create_generic_event(
      title: "You have #{calories} calories left today",
      image_url: 'http://catfood.io/cat_happy.png',
      note: message
    ) 
  end

  def create_twilio_message
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    client.account.messages.create({
      from: '+15617392747',
      to: user.phone_number,
      body: message
    })
  end
end
