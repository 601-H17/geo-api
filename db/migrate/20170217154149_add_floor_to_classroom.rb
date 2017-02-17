class AddFloorToClassroom < ActiveRecord::Migration
  def change
    add_column :classrooms, :floor, :integer
  end
end
