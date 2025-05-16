class RenameTileColumn < ActiveRecord::Migration[8.0]
  def change
    rename_column :solves, :tile, :tile_notation
  end
end
