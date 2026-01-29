class Transaction < ApplicationRecord
  belongs_to :category

  enum transaction_type: { expense: 0, income: 1 }
end
