class Meal < ActiveRecord::Base
  after_create :create_associated_suggestion

  belongs_to :user
  has_one :suggestion

  def create_associated_suggestion
    create_suggestion(
      user_id: user.id,
      to_be_eaten_at: Time.now + 4.hours,
      message: suggested_message,
      calories: suggested_calories,
      carbs: suggested_carbs,
      fats: suggested_fats,
      proteins: suggested_proteins
    )
  end

  private

  def suggested_calories
    user.daily_calories - calories
  end

  def suggested_carbs
    user.daily_carbs - calories
  end

  def suggested_fats
    user.daily_fats - fats
  end

  def suggested_proteins
    user.daily_proteins - proteins
  end

  def suggested_message
<<-EOS
You just had #{title}

In order to maintain a healthy diet today, catfood recommends that you eat the following in the next few meals:
#{suggested_calories.round} more calories,
#{suggested_carbs.round}g of more carbs,
#{suggested_fats.round}g of more fats and
#{suggested_proteins.round}g of more protein

Your next meal should be around:
#{(Time.now + 4.hours).strftime('%I:%M%p')}
EOS
  end
end
