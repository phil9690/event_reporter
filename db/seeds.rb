# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.create!(first_name: 'default', last_name: 'admin', username: 'admin', authority: 'admin', password: 'password', password_confirmation: 'password')

for employee in 0..50
  name = Faker::Name.name.split
  Employee.create!(first_name: name[0], last_name: name[1], active: true, pid: 95000 + employee)
end

for event in 0.
