class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :addr
      t.boolean :default, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
