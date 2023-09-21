class ChangeCodeTypeInProducts < ActiveRecord::Migration[7.0]
  def up
    change_column :products, :code, :string
  end

  def down
    change_column :products, :code, :integer, using: 'code::integer'
  end
end
