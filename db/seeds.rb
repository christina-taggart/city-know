
require "csv"
# exec('pwd')
# cities_csv = CSV.read("./db/cities.tsv", { :col_sep => "\t" })



CSV.foreach("db/world_cities.csv") do |row|
  City.create(name: row[0], country: row[2], lat: row[3], long: row[4])
  # p city.inspect
  # p city.valid?
end