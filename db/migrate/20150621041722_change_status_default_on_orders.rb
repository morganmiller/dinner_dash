class ChangeStatusDefaultOnOrders < ActiveRecord::Migration
  def change
    change_column_default :orders, :status, "ordered"
  end
end
