require 'spec_helper'

describe Expense do 
  it { should belong_to :category }

  it 'returns expenses for a given range' do
    expense1 = Expense.create(:description => 'football game', :date => Date.parse("2013/09/15"))
    expense2 = Expense.create(:description => 'new tv', :date => Date.parse("2013/10/15"))
    Expense.between(Date.parse("2013/9/1"), Date.parse("2013/9/30")).should eq [expense1]
  end
end