class AddFloorToMap < ActiveRecord::Migration
  def change
    add_column :maps, :floor, :integer
  end
end
