# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Technology.destroy_all
technologies = [{:name => 'Django', 
                :icon_path => 'django.jpg'},
                {:name => 'Python',
                 :icon_path => 'python.png'},
                 {:name => 'Ruby',
                  :icon_path => 'ruby.jpg'},
                 {:name => 'Ruby on Rails',
                  :icon_path => 'ruby_on_rails.jpg'}]
technologies.map{|technology| Technology.find_or_create_by_name_and_icon_path(technology[:name], technology[:icon_path])}
p User.destroy_all