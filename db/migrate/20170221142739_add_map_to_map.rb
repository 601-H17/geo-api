class AddMapToMap < ActiveRecord::Migration
  def change
    add_column :maps, :map, :string
  end
end
