# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(username: "Master admin", email: "master@admin.com", password: "admin", master_admin: true)
Admin.create(username: "NoMaster admin", email: "nomaster@admin.com", password: "admin", master_admin: false)