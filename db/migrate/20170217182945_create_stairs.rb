class CreateStairs < ActiveRecord::Migration
  def change
    create_table :stairs do |t|
      t.string :name
      t.integer :floor
      t.references :point, index: true

      t.timestamps null: false
    end
    add_foreign_key :stairs, :points
  end
end
