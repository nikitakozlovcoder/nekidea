class ChangeDefaultIsGeneral < ActiveRecord::Migration[6.0]
  def change
    add_column :duties, :is_general , :boolean, :default => false
  end
end
