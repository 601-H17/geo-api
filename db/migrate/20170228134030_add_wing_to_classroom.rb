class AddWingToClassroom < ActiveRecord::Migration
  def change
    add_column :classrooms, :wing, :string, default: ""
  end
end
