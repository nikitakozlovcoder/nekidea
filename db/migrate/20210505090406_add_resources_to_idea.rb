class AddResourcesToIdea < ActiveRecord::Migration[6.0]
  def change
    add_column :ideas, :resources , :text
  end
end
