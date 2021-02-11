class CreateDuties < ActiveRecord::Migration[6.0]
  def change
    create_table :duties do |t|
      t.string :name

      t.timestamps
    end
    create_table :duties_users, id: false do |t|
      t.belongs_to :duty
      t.belongs_to :user
    end
  end
end
