class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:jawbone]

  has_many :meals, dependent: :destroy
  has_many :suggestions, dependent: :destroy

  def daily_calories
    if gender == 'male'
      gender_offset = 5
    elsif gender == 'female'
      gender_offset = -161
    end
    bmr = 10 * weight + 6.25 * (height * 100) - 5 * age + gender_offset

    bmr * 1.4
  end

  def daily_carbs
    (250 * daily_calories) / 2000
  end

  def daily_fats
    (61 * daily_calories) / 2000
  end

  def daily_proteins
    (87.5 * daily_calories) / 2000
  end
end
