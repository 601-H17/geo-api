class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name, default: ''
      t.string :description, default: ''

      t.timestamps null: false
    end
  end
end
