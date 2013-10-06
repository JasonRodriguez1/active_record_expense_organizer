class Category < ActiveRecord::Base
  has_many :expenses

  def percent_of_total
    total_expenses = Expense.all.reduce(0) { |total, expense| total + expense.amount }
    total_category = expenses.reduce(0) { |total, expense| total + expense.amount}
    percentage = (total_category / total_expenses) * 100
    percentage.to_i
  end
end