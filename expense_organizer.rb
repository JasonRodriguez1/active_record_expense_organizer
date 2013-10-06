require 'active_record'
require './lib/expense'
require './lib/category'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def welcome
  puts "Expense Report v0.1"
  menu
end

def menu(expenses=Expense.all)
  puts "[A]dd an expense. [L]ist expenses. Show [P]ercentage of expenses. [N]ew category. [D]elete category. [S]how categories. Date [R]ange. E[x]it."
  input = gets.chomp
  case input.downcase
  when 'a'
    choose_category
  when 'd'
    delete_category
  when 'l'
    list_expenses(expenses)
  when 'p'
    show_percentage
  when 'n' 
    new_category
  when 's'
    show_categories
  when 'r'
    date_range
  when 'x'
    puts 'Goodbye.'
  else
    puts 'I\'m sorry, I do not understand.'
    menu
  end
end

def choose_category
  puts "Please choose the type of expense to report: "
  Category.all.each_with_index {|category, index| puts "#{index}-#{category.name}"}
  choice = gets.chomp.to_i
  add_expense(Category.all[choice])
end

def delete_category
  puts "Please choose the type of expense to delete: "
  Category.all.each_with_index {|category, index| puts "#{index}-#{category.name}"}
  choice = gets.chomp.to_i
  Category.all[choice].delete
  menu
end


def add_expense(category)
  print "Please enter a description: "
  description = gets.chomp
  print "Enter the amount: "
  amount = gets.chomp
  print "Enter the date (YYYY/MM/DD): "
  date = gets.chomp
  expense = category.expenses.new(:description => description, :amount => amount, :date => date)
  if expense.save
    puts "Saved!"
  else
    puts "Not a valid expense"
  end
  menu
end

def list_expenses(expenses)
  expenses.each_with_index { |expense, index| puts "#{index + 1}. #{expense.description} - $#{expense.amount} - #{expense.date} - #{expense.category.name}" }
  menu
end

def delete_expenses
  puts "Please choose the expense to delete: "
  Expense.all.each_with_index {|expense, index| puts "#{index}-#{expense.name}"}
  choice = gets.chomp.to_i
  Expense.all[choice].delete
  menu
end

def show_percentage
  puts "Listed are your category expense percentages: "
  Category.all.each{|category| puts "#{category.name}-#{category.percent_of_total}%"}
  menu
end

def show_categories
  Category.all.each_with_index { |category, index| puts "#{index + 1}. #{category.name}" }
  menu
end

def new_category
  print "Please enter the name of the category: "
  name = gets.chomp
  category = Category.new(:name => name)
  if category.save
    "Saved!"
  else
    "Sorry, that is not a valid category"
  end
  menu
end

def date_range
  print "Enter the start date: "
  start_date = Date.parse(gets.chomp)
  print "Enter the end date: "
  end_date = Date.parse(gets.chomp)
  expenses_in_range = Expense.between(start_date, end_date)
  menu(expenses_in_range)
end
welcome
