# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



InvoiceItem.destroy_all
Transaction.destroy_all
Invoice.destroy_all
Coupon.destroy_all
Item.destroy_all
Merchant.destroy_all
Customer.destroy_all

system("rails csv_load:all")

@merchant = Merchant.create!(name: "BicycleMicycle's Shed")
@coupon_1 = @merchant.coupons.create!(name: "Almost Free", coupon_type: "percent", money_off: 99, code: "HAVEIT", status: 0)
@coupon_2 = @merchant.coupons.create!(name: "50% Off", coupon_type: "percent", money_off: 50, code: "GET50", status: 0)
@coupon_3 = @merchant.coupons.create!(name: "1 Dolla", coupon_type: "dollars", money_off: 100, code: "1DOLLA", status: 0)
@coupon_4 = @merchant.coupons.create!(name: "10% Off", coupon_type: "percent", money_off: 10, code: "DECENT10", status: 0)

@item_1 = @merchant.items.create!(name: "Super Good but very used bike", description: "At least 1 or two trips left in this once in a lifetime opportunity of a bike.", unit_price: 50000, status: 1)
@item_2 = @merchant.items.create!(name: "Old Tire", description: "A once good tire, sure to leave you stranded in the mountains.", unit_price: 123456789, status: 1)
@item_3 = @merchant.items.create!(name: "Gravel Bike", description: "This one is actually not for sale, unless you have 10 million dollars.", unit_price: 1000000000, status: 1)

@customer_1 = Customer.create!(first_name: "Tadej", last_name: "Pogacar")

@invoice_1 = @customer_1.invoices.create!(status: 1, coupon_id: @coupon_1.id)
@invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 50000, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id)
@invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 123456789, status: 1, invoice_id: @invoice_1.id, item_id: @item_2.id)
@transaction_1 = @invoice_1.transactions.create!(credit_card_number: "4147202434567890", result: 0)

@invoice_2 = @customer_1.invoices.create!(status: 1, coupon_id: @coupon_3.id)
@invoice_item_3 = InvoiceItem.create!(quantity: 1, unit_price: 1000000000, status: 1, invoice_id: @invoice_2.id, item_id: @item_3.id)
@transaction_2 = @invoice_2.transactions.create!(credit_card_number: "4147202434567890", result: 0)