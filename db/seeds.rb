# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

categories = [
  { name: "Alimentação", color: "#FF5733", monthly_limit: 800.0 },
  { name: "Lazer", color: "#33C1FF", monthly_limit: 300.0 },
  { name: "Fixos", color: "#B833FF", monthly_limit: 2000.0 }
]

Category.create!(categories)
puts "Pronto! #{Category.count} categorias criadas."
