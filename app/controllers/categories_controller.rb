class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    
    # Criamos um mapa de dados personalizado para o frontend
    render json: @categories.map { |category|
      {
        id: category.id,
        name: category.name,
        color: category.color,
        monthly_limit: category.monthly_limit,
        total_spent: category.total_spent_this_month, # Método que criamos no Model
        limit_exceeded: category.limit_exceeded?      # Lógica de alerta que criamos
      }
    }
  end
end
