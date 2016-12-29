class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.decimal :total_price, precision: 8, scale: 2
      t.references :address, foreign_key: true
      t.boolean :paid, default: false
      t.boolean :posted, default: false
      t.boolean :received, default: false
      t.string :pay_method
      t.string :deliver_method

      t.timestamps
    end
  end
end
