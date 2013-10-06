require './lib/expense'

class AddCategoryToExpensesWithoutCategories < ActiveRecord::Migration
  def change
    Expense.all.each do |expense|
      expense.update_attributes(:category_id => 1) if expense.category_id.nil?
    end
  end
end
