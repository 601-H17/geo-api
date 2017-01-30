json.extract! admin, :id, :username, :email, :master_admin, :created_at, :updated_at
json.url admin_url(admin, format: :json)