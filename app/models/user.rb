class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:jawbone]

  has_many :meals
  has_many :suggestions

  def max_calories(weight, height, age)
    if self.gender == 'male'
      genderOffset = 5
    elsif self.gender == 'female'
      genderOffset = -161
    end
    #activity = {sedentary: 1500, light: 3000,
    #            moderate: 5000, active: 10000,
    #           extra: 20000}
    activity = 1.375
    bmr = 10 * weight + 6.25 * height - 5 * age + genderOffset

    total_daily_calories = bmr * activity
  end

  def max_carbs
  end

  def max_fats
  end

  def max_proteins
  end

end
