class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.column :name, :string

      t.timestamps
    end
    add_column :expenses, :category_id, :integer
  end
end
