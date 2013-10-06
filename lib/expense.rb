class Expense < ActiveRecord::Base
  belongs_to :category 

  def self.between(start_date, end_date)
    Expense.where("date >= :start_date AND date <= :end_date", {start_date: start_date, end_date: end_date})
  end
end