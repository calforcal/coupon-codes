require "rails_helper"

RSpec.describe "Merchants Coupon Show Page" do
  describe "merchants/:id/coupons/:id" do
    let!(:merchant_1) { create(:merchant) }
    let!(:merchant_2) { create(:merchant) }
  
    let!(:customer_1) { create(:customer) }
    let!(:customer_2) { create(:customer) }
    let!(:customer_3) { create(:customer) }
    let!(:customer_4) { create(:customer) }
    let!(:customer_5) { create(:customer) }
    let!(:customer_6) { create(:customer) }
    let!(:customer_7) { create(:customer) }
  
    let!(:item_1) { create(:item, merchant_id: merchant_1.id) }
    let!(:item_2) { create(:item, merchant_id: merchant_1.id) }
    let!(:item_3) { create(:item, merchant_id: merchant_1.id) }
    let!(:item_4) { create(:item, merchant_id: merchant_1.id) }
    let!(:item_5) { create(:item, merchant_id: merchant_1.id) }
    let!(:item_6) { create(:item, merchant_id: merchant_1.id) }
  
    let!(:transaction_1) { create(:transaction, invoice_id: invoice_1.id, result: 0) }
    let!(:transaction_2) { create(:transaction, invoice_id: invoice_2.id, result: 0) }
    let!(:transaction_3) { create(:transaction, invoice_id: invoice_3.id, result: 0) }
    let!(:transaction_4) { create(:transaction, invoice_id: invoice_4.id, result: 0) }
    let!(:transaction_5) { create(:transaction, invoice_id: invoice_5.id, result: 0) }
    let!(:transaction_6) { create(:transaction, invoice_id: invoice_6.id, result: 0) }
    let!(:transaction_7) { create(:transaction, invoice_id: invoice_6.id, result: 0) }
  
    let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 0, coupon_id: coupon_1.id)}
    let!(:invoice_2) { create(:invoice, customer_id: customer_2.id, status: 0, coupon_id: coupon_1.id)}
    let!(:invoice_3) { create(:invoice, customer_id: customer_3.id, status: 0, coupon_id: coupon_1.id)}
    let!(:invoice_4) { create(:invoice, customer_id: customer_4.id, status: 0, coupon_id: coupon_1.id)}
    let!(:invoice_5) { create(:invoice, customer_id: customer_5.id, status: 0, coupon_id: coupon_1.id)}
    let!(:invoice_6) { create(:invoice, customer_id: customer_5.id, status: 0)}
  
    let!(:invoice_item_1) { create(:invoice_item, unit_price: 2000, invoice_id: invoice_1.id, item_id: item_1.id) }
    let!(:invoice_item_2) { create(:invoice_item, unit_price: 3000, invoice_id: invoice_2.id, item_id: item_2.id) }
    let!(:invoice_item_3) { create(:invoice_item, unit_price: 4000, invoice_id: invoice_3.id, item_id: item_3.id) }
    let!(:invoice_item_4) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_4.id, item_id: item_4.id) }
    let!(:invoice_item_5) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_5.id, item_id: item_5.id) }
  
    let!(:merchant_3) { create(:merchant) }
    let!(:customer_8) { create(:customer) }
    let!(:item_7) { create(:item, merchant_id: merchant_3.id) }
    let!(:invoice_7) { create(:invoice, customer_id: customer_8.id, status: 0)}
    let!(:invoice_8) { create(:invoice, created_at: "2022-06-06 21:33:44 UTC", customer_id: customer_8.id, status: 0)}
    let!(:transaction_8) { create(:transaction, invoice_id: invoice_7.id, result: 0) }
    let!(:invoice_item_6) { create(:invoice_item, unit_price: 5000, status: 2, invoice_id: invoice_7.id, item_id: item_7.id) }
    let!(:invoice_item_7) { create(:invoice_item, unit_price: 5000, status: 2, invoice_id: invoice_8.id, item_id: item_7.id) }
  
    let!(:coupon_1) { merchant_1.coupons.create!(name: "50% off", code: "GET50", coupon_type: 0, status: 0, money_off: 50) }
    let!(:coupon_2) { merchant_1.coupons.create!(name: "$10 off", code: "TAKE10", coupon_type: 1, status: 0, money_off: 10) }
    let!(:coupon_3) { merchant_1.coupons.create!(name: "25% off", code: "GET25", coupon_type: 0, status: 0, money_off: 25) }

    it "displays a coupons information and count of times used" do
      visit merchant_coupon_path(merchant_1, coupon_1)

      expect(page).to have_content("#{coupon_1.name}")
      expect(page).to have_content("Code: #{coupon_1.code}")
      expect(page).to have_content("Percent Off: #{coupon_1.money_off}")
      expect(page).to have_content("Status: #{coupon_1.status}")
      expect(page).to have_content("Number of Uses: 5")
    end
  end
end