class AddIndexToStates < ActiveRecord::Migration
  def change
    add_index :states, :id
    add_index :states, :name
  end
end
