class CreateClassroomsTags < ActiveRecord::Migration
  def change
    create_table :classrooms_tags, id: false do |t|
      t.references :classroom, null: false
      t.references :tag, null: false
    end

    add_index :classrooms_tags, [:classroom_id, :tag_id], unique: true
  end
end
