class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :idea_id

      t.timestamps
    end
  end
end
