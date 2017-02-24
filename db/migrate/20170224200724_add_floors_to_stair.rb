class AddFloorsToStair < ActiveRecord::Migration
  def change
    remove_column :stairs, :floor
    add_column :stairs, :floor_max, :integer, default: 0
    add_column :stairs, :floor_min, :integer, default: 0
  end
end
