class AddIndexToPayments < ActiveRecord::Migration
  def change
    add_index :payments, :process_number
    add_index :payments, :enterprise_id
  end
end
