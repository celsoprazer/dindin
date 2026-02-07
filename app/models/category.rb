class Category < ApplicationRecord
  has_many :transactions, dependent: :destroy

  def total_spent_this_month
    transactions.confirmed
                .expense
                .where(date: Date.today.all_month)
                .sum(:amount)
  end

  def limit_exceeded?
    return false if monthly_limit.nil?
    
    total_spent_this_month > monthly_limit
  end
end
