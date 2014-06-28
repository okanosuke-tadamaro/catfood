class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.integer :user_id
      t.integer :meal_id
      t.datetime :to_be_eaten_at
      t.text :message
      t.integer :calories
      t.integer :carbs
      t.integer :fats
      t.integer :proteins

      t.timestamps
    end
  end
end
