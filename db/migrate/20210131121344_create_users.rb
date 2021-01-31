class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :mail
      t.text :password_digest
      t.datetime :birth_date
      t.boolean :is_admin
      t.integer :rating

      t.timestamps
    end
  end
end
