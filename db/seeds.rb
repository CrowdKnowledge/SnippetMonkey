# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Technology.create(name: 'Django', icon_path: 'django.jpg')
Technology.create(name: 'Python', icon_path: 'python.png')
Technology.create(name: 'Ruby', icon_path: 'ruby.jpg')
Technology.create(name: 'Ruby on Rails', icon_path: 'ruby_on_rails.jpg')
