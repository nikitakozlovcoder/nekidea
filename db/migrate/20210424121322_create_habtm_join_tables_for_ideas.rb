class CreateHabtmJoinTablesForIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :ideas_upusers, id: false do |t|
      t.belongs_to :idea
      t.belongs_to :user
    end
    create_table :ideas_downusers, id: false do |t|
      t.belongs_to :idea
      t.belongs_to :user
    end
  end
end
