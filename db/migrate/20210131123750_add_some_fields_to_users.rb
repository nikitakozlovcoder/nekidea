class AddSomeFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
   add_column :users, :name , :string, :default => ""
   add_column :users, :surname , :string, :default => ""
   add_column :users, :patronymic , :string, :default => ""
   add_column :users, :restore_date , :datetime
  end
end
