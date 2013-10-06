require 'spec_helper'

describe Category do 
  it {should have_many :expenses}

  describe 'percent_of_total' do
    it 'gives the percentage spent in a category' do
      category1 = Category.create(:name => 'food')
      category2 = Category.create(:name => 'medical')
      expense1 = category1.expenses.create(:description => 'pizza', :amount => 10.00)
      expense2 = category2.expenses.create(:description => 'pepto-bismo', :amount => 15.00)
      category1.percent_of_total.should eq 40
    end
  end
end