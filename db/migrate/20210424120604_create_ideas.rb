class CreateIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :ideas do |t|
      t.integer :vote_id
      t.integer :user_id
      t.string :title
      t.text :body
      t.integer :created_on
      t.integer :archived_on
      t.integer :instance_id
      t.integer :idea_state

      t.timestamps
    end
  end
end
