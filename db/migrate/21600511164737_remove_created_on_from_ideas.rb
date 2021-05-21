class RemoveCreatedOnFromIdeas < ActiveRecord::Migration[6.0]
  def change
    remove_column :ideas, :created_on
    add_column :ideas, :iteration_created, :integer
  end
end
