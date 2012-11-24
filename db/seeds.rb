# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.new(:name => 'SuperAdmin').save!
Role.new(:name => 'Reseller').save!

User.new(:email => 'admin@localhost.localhost', :password => 'simplecos', :password_confirmation => 'simplecos', :role_ids => [1]).save!
User.new(:email => 'client@localhost.localhost', :password => 'simplecos', :password_confirmation => 'simplecos', :role_ids => [2]).save!
