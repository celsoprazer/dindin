# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Limpando o banco de dados..."
Transaction.destroy_all
Category.destroy_all

puts "Criando categorias..."
alimentacao = Category.create!(name: "Alimentação", color: "#FF5733", monthly_limit: 800.0)
lazer       = Category.create!(name: "Lazer", color: "#33C1FF", monthly_limit: 300.0)
saude       = Category.create!(name: "Saúde", color: "#75FF33", monthly_limit: 200.0)

puts "Criando transações de teste..."

# Categoria: Alimentação
# Gasto confirmado (deve aparecer no total_spent)
Transaction.create!(
  description: "Almoço Executivo",
  amount: 45.0,
  date: Date.today,
  transaction_type: :expense,
  status: :confirmed,
  category: alimentacao
)

# Gasto pendente (NÃO deve somar no total_spent ainda)
Transaction.create!(
  description: "Jantar de Sexta (Previsão)",
  amount: 120.0,
  date: Date.today + 2.days,
  transaction_type: :expense,
  status: :pending,
  category: alimentacao
)

# Categoria: Lazer
# Receita (NÃO deve somar como gasto)
Transaction.create!(
  description: "Reembolso Cinema",
  amount: 30.0,
  date: Date.today,
  transaction_type: :income,
  status: :confirmed,
  category: lazer
)

puts "Seeds finalizados com sucesso!"
puts "Total de Categorias: #{Category.count}"
puts "Total de Transações: #{Transaction.count}"
