# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"
# exec('pwd')
# cities_csv = CSV.read("./db/cities.tsv", { :col_sep => "\t" })



CSV.foreach("db/world_cities.csv") do |row|
  City.create(name: row[0], country: row[2], lat: row[3], long: row[4])
  # p city.inspect
  # p city.valid?
end