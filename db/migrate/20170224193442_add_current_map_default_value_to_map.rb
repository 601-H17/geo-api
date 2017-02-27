class AddCurrentMapDefaultValueToMap < ActiveRecord::Migration
  def change
    change_column :maps, :currentMap, :boolean, default: false
  end
end
