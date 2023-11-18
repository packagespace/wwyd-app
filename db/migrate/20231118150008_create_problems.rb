class CreateProblems < ActiveRecord::Migration[7.1]
  def change
    create_table :problems do |t|
      t.string :title
      t.string :hand
      t.string :solution
      t.text :explanation

      t.timestamps
    end
  end
end
