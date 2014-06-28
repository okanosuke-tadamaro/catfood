class DigestsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]

	def create
    if params['events'].first['action'] == 'creation'
      user_for_meal.meals.create(
        eaten_at: Time.now,
        title: jawbone_meal_title,
        note: jawbone_meal_note,
        calories: jawbone_meal['calories'],
        carbs: jawbone_meal['carbohydrate'],
        fats: jawbone_meal['fat'],
        proteins: jawbone_meal['protein']
      )
    end
    render nothing: true, status: 200

    #account_sid = ENV['AccSID']
    #auth_token = ENV['AuthToken']
    #@client = Twilio::REST::Client.new account_sid, auth_token
    #@client.account.messages.create({:from => '+15617392747', :to => phone_number, :body => "Hi #{first_name}, You should eat your next meal at #{time}. Try eating some #{rec}"})
  end

  private

  def user_for_meal
    User.find_by(jawbone_xid: params['events'].last['user_xid'])
  end

  def jawbone_access_token
    user_for_meal.jawbone_access_token
  end

  def jawbone_client
    @jawbone_client ||= Jawbone::Client.new(jawbone_access_token)
  end

  def jawbone_meal_title
    jawbone_client.meal(params['events'].last['event_xid'])['data']['title']
  end

  def jawbone_meal_note
    jawbone_client.meal(params['events'].last['event_xid'])['data']['note']
  end

  def jawbone_meal
    jawbone_client.meal(params['events'].last['event_xid'])['data']['items']['items'].last
  end
end
