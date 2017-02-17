# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(username: "Master admin", email: "master@admin.com", password: "admin", master_admin: true)
Admin.create(username: "NoMaster admin", email: "nomaster@admin.com", password: "admin", master_admin: false)

point165 = Point.create(lat: -71.28741894110, lng: 46.78601674403)
point164 = Point.create(lat: -71.28730301717, lng: 46.78602796227)

Classroom.create(name: "G-165", description: "A beautiful classroom really clean...", floor: 1, point: point165)
Classroom.create(name: "G-164", description: "Really not nice, much classroom, wow", floor: 1, point: point164)