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

  def create_twilio_message
    #account_sid = ENV['AccSID']
    #auth_token = ENV['AuthToken']
    #@client = Twilio::REST::Client.new account_sid, auth_token
    #@client.account.messages.create({:from => '+15617392747', :to => phone_number, :body => "Hi #{first_name}, You should eat your next meal at #{time}. Try eating some #{rec}"})
  end
end
