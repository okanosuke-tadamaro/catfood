class DigestsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]

	def create
    render nothing: true, status: 200

    account_sid = ENV[AccSID],
    auth_token = ENV[AuthToken]



    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.messages.create({
                                        :from => '+15617392747',
                                        :to => phone_num,
                                        :body => "Hi #{email}, You should eat your next meal at #{time}. Try eating some #{rec}"
                                    })
  end

end
