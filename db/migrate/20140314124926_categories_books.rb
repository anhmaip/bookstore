class CategoriesBooks < ActiveRecord::Migration
  def change
    create_table :categories_books, :id => false do |t|
      t.integer :category_id
      t.integer :book_id
    end
  end
end
