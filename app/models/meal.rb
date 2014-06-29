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
    "Thanks for eating #{title}! In order to maintain a healthy diet today, cat food recommends that you eat #{suggested_calories} more calories, #{suggested_carbs}g of more carbs, #{suggested_fats}g of more fats and #{suggested_proteins}g of more protein"
  end
end
