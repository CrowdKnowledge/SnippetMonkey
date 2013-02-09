# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

technologies = [{:name => 'My Custom Language', 
                :icon_path => '404.jpg'},
                {:name => 'Django', 
                :icon_path => 'django.jpg'},
                {:name => 'Python',
                 :icon_path => 'python.png'},
                 {:name => 'Ruby',
                  :icon_path => 'ruby.jpg'},
                 {:name => 'Ruby on Rails',
                  :icon_path => 'ruby_on_rails.jpg'}]
technologies.map{|technology| Technology.find_or_create_by_name_and_icon_path(technology[:name], technology[:icon_path])}
doc = Hpricot(open("http://cgibin.erols.com/ziring/cgi-bin/cep/cep.pl?_total=1&_format=index&_userlink=1"))
  pars = Array.new
doc.search("dd/b/a").each do |tech|
  file = Dir["#{Rails.root}/public/languages/#{tech.inner_html}.*"][0]
  icon_path = file.blank? ? "404.jpg" : File.basename(file)
  p tech.inner_html, icon_path
  p Technology.find_or_create_by_name_and_icon_path(tech.inner_html, icon_path)
end
