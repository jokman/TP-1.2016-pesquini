class AddIndexToEnterprisesCnpj < ActiveRecord::Migration
  def change
    add_index :enterprises, :cnpj
  end  
end
