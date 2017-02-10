class AddNameToApiKeyTable < ActiveRecord::Migration
  def change
    add_column :api_keys, :name, :string, default: ""
  end
end
