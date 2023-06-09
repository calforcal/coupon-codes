class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code, unique: true
      t.integer :status
      t.integer :money_off
      t.integer :coupon_type

      t.timestamps
    end
    add_index :coupons, :code, unique: true
  end
end
