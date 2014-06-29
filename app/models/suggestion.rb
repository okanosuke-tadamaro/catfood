class Suggestion < ActiveRecord::Base
  after_create :update_subscribers

  belongs_to :user
  belongs_to :meal

  def update_subscribers
    create_jawbone_custom_event
    #create_twilio_message
  end

  private

  def jawbone_client
    @jawbone_client ||= Jawbone::Client.new(user.jawbone_access_token)
  end

  def create_jawbone_custom_event
    jawbone_client.create_generic_event(
      title: "Healthy eating suggestion",
      note: message
    ) 
  end
end
