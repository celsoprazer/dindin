class Transaction < ApplicationRecord
  belongs_to :category

  enum transaction_type: { expense: 0, income: 1 }
  enum status: { pending: 0, confirmed: 1}
end
