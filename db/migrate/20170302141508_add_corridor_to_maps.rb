class AddCorridorToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :corridor, :string
  end
end
