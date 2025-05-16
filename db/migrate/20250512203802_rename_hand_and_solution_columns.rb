class RenameHandAndSolutionColumns < ActiveRecord::Migration[8.0]
  def change
    rename_column :problems, :hand, :hand_notation
    rename_column :problems, :solution, :solution_notation
  end
end
