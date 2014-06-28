class Meal < ActiveRecord::Base
  after_create :create_associated_suggestion

  belongs_to :user
  has_one :suggestion

  def create_associated_suggestion
    create_suggestion(
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
    ''
  end
end
