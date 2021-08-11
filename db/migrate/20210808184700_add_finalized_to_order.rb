class AddFinalizedToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :finalized, :boolean, null: false, default: false
  end
end
