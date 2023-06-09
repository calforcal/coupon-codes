require "rails_helper"

RSpec.describe "Merchants Items Index" do
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

  let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 0)}
  let!(:invoice_2) { create(:invoice, customer_id: customer_2.id, status: 0)}
  let!(:invoice_3) { create(:invoice, customer_id: customer_3.id, status: 0)}
  let!(:invoice_4) { create(:invoice, customer_id: customer_4.id, status: 0)}
  let!(:invoice_5) { create(:invoice, customer_id: customer_5.id, status: 0)}
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

  let!(:coupon_1) { merchant_3.coupons.create!(name: "50% off", code: "GET50", percent_off: 50, status: 0) }
  let!(:coupon_2) { merchant_3.coupons.create!(name: "$10 off", code: "TAKE10", dollar_off: 10, status: 0) }
  let!(:coupon_3) { merchant_3.coupons.create!(name: "25% off", code: "GET25", percent_off: 25, status: 0) }

  it "displays all of the merchants coupons, their amount off and a link to their show page" do
    visit merchant_coupons_path(merchant_3)
    save_and_open_page
    within ".active-coupons" do
      within ".coupon-#{coupon_1.id}-details" do
        expect(page).to have_link("#{coupon_1.name}")
        expect(page).to have_content("Code: #{coupon_1.code}")
        expect(page).to have_content("Percent Off: #{coupon_1.percent_off}")
        expect(page).to_not have_content("Dollar Off: #{coupon_1.dollar_off}")
      end

      within ".coupon-#{coupon_2.id}-details" do
        expect(page).to have_link("#{coupon_2.name}")
        expect(page).to have_content("Code: #{coupon_2.code}")
        expect(page).to_not have_content("Percent Off: #{coupon_2.percent_off}")
        expect(page).to have_content("Dollar Off: #{coupon_2.dollar_off}")
      end

      within ".coupon-#{coupon_3.id}-details" do
        expect(page).to have_link("#{coupon_3.name}")
        expect(page).to have_content("Code: #{coupon_3.code}")
        expect(page).to have_content("Percent Off: #{coupon_3.percent_off}")
        expect(page).to_not have_content("Dollar Off: #{coupon_3.dollar_off}")
      end
    end
  end
end