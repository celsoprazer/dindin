class TransactionsController < ApplicationController
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      # Se salvar com sucesso, devolvemos a transação em JSON para o Vue
      render json: @transaction, status: :created
    else
      # Se houver erro (ex: campo vazio), devolvemos os erros para o Vue mostrar
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

    def index
    @transactions = Transaction.includes(:category).all
    render json: @transactions.as_json(include: :category)
    end

  private

  def transaction_params
    # Permitimos apenas os campos que definimos nos enums e no banco
    params.require(:transaction).permit(
      :description, 
      :amount, 
      :date, 
      :category_id, 
      :transaction_type, 
      :status
    )
  end
end
