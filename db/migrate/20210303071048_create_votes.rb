class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :type
      t.text :body
      t.string :title
      t.datetime :active_to
      t.text :iter_array
      t.integer :current_iter

      t.timestamps
    end
  end
end
