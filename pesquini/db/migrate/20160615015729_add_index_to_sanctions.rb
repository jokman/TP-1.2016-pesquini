class AddIndexToSanctions < ActiveRecord::Migration
  def change
    add_index :sanctions, :process_number
    add_index :sanctions, :enterprise_id
    add_index :sanctions, :sanction_type_id
  end
end
