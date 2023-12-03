class CreateSolves < ActiveRecord::Migration[7.1]
  def change
    create_table :solves do |t|
      t.string :tile
      t.references :problem, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
