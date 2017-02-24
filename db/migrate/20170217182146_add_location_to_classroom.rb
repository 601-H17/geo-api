class AddLocationToClassroom < ActiveRecord::Migration
  def change
    add_reference :classrooms, :point, index: true
  end
end
