class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.integer :user_id
      t.datetime :eaten_at
      t.string :title
      t.text :note
      t.integer :calories
      t.integer :carbs
      t.integer :fats
      t.integer :proteins

      t.timestamps
    end
  end
end
