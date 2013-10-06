require 'active_record'
require 'rspec'
require 'pry'
require 'shoulda-matchers'
require 'expense'
require 'category'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Expense.all.each {|expense| expense.destroy}
    Category.all.each {|category| category.destroy}
  end
end