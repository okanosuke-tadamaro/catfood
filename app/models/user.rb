class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:jawbone]

  has_many :meals
  has_many :suggestions

  def max_calories
  end

  def max_carbs
  end

  def max_fats
  end

  def max_proteins
  end
end
