class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.decimal :lat, default: 0.0
      t.decimal :lng, default: 0.0

      t.timestamps null: false
    end
  end
end
