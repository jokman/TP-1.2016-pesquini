class RemoveIndexSanctions < ActiveRecord::Migration
  def change
    remove_index :sanctions, :enterprise_id
  end
end
