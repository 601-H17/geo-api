class AddCurrentMapToMap < ActiveRecord::Migration
  def change
    add_column :maps, :currentMap, :boolean
  end
end
