class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.integer :percent_off
      t.integer :dollar_off

      t.timestamps
    end
    add_index :coupons, :code, unique: true
  end
end
