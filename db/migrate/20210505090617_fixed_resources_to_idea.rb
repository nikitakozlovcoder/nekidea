class FixedResourcesToIdea < ActiveRecord::Migration[6.0]
  def change
    change_column :ideas, :resources, :text, default: '[]'
  end
end
