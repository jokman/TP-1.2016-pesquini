class AddIndexToSanctionTypes < ActiveRecord::Migration
  def change
    add_index :sanction_types, :id
  end
end
