class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:jawbone]

  has_many :meals
  has_many :suggestions

  def daily_calories
    if gender == 'male'
      genderOffset = 5
    elsif gender == 'female'
      genderOffset = -161
    end
    #activity = {sedentary: 1500, light: 3000,
    #            moderate: 5000, active: 10000,
    #           extra: 20000}
    activity = 1.375
    bmr = 10 * weight + 6.25 * height - 5 * age + genderOffset

    bmr * activity
  end

  def daily_carbs
    (250 * daily_calories)/2000
  end

  def daily_fats
    (61 * daily_calories)/2000
  end

  def daily_proteins
    (87.5 * daily_calories)/2000
  end

end
