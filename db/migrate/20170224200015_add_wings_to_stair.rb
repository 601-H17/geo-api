class AddWingsToStair < ActiveRecord::Migration
  def change
    add_column :stairs, :wing, :string, default: ""
  end
end
