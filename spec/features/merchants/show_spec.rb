require "rails_helper"

RSpec.describe "/merchants/:id/dashboard" do
  describe "As a visitor" do
    describe "when I visit a merchants show page" do
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

      it "directs me to the merchants dashboard where I see the merchants name" do
        visit merchant_path(merchant_1)

        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)

        visit merchant_path(merchant_2)
        expect(page).to have_content(merchant_2.name)
        expect(page).to_not have_content(merchant_1.name)
      end

      it "links to the merchants items index" do
        visit merchant_path(merchant_1)
        
        click_link "My items"
        expect(current_path).to eq(merchant_items_path(merchant_1))
        expect(page).to have_content("#{merchant_1.name} Items")
        visit merchant_path(merchant_2)

        click_link "My items"
        expect(current_path).to eq(merchant_items_path(merchant_2))
        expect(page).to have_content("#{merchant_2.name} Items")
      end

      it "links to the merchants invoices index" do
        visit merchant_path(merchant_1)

        click_link "My invoices"
        expect(current_path).to eq(merchant_invoices_path(merchant_1))
        expect(page).to have_content("#{merchant_1.name} Invoices")

        visit merchant_path(merchant_2)

        click_link "My invoices"
        expect(current_path).to eq(merchant_invoices_path(merchant_2))

        expect(page).to have_content("#{merchant_2.name} Invoices")
      end

      it "see top 5 customers on on dashboard" do
        visit merchant_path(merchant_1)

        expect(page).to have_content("Top 5 Customers")
        expect(page).to have_content(customer_1.first_name)
        expect(page).to have_content(customer_2.first_name)
        expect(page).to have_content(customer_3.first_name)
        expect(page).to have_content(customer_4.first_name)
        expect(page).to have_content(customer_5.first_name)
        expect(page).not_to have_content(customer_6.first_name)
        expect(page).not_to have_content(customer_7.first_name)
      end

      it "shows section for 'Items Ready to Ship'" do
        visit merchant_path(merchant_3)

        expect(page).to have_content("Items Ready to Ship")
      end

      it "shows list of names of all items ordered but not shipped in 'Items Ready to ship'" do
        visit merchant_path(merchant_3)

        pending_items = item_7.name
        expect(page).to have_content(pending_items)
      end

      it "shows invoice id next to items not shipped with link to merchants invoice show page" do
        visit merchant_path(merchant_3)

        expect(page).to have_link("#{invoice_7.id}")
        click_on("#{invoice_7.id}")
        expect(current_path).to eq(merchant_invoice_path(merchant_3, invoice_7))
      end

      it "shows invoice id with formatted date and time" do
        visit merchant_path(merchant_3)

        expect(page).to have_content("#{invoice_7.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
      end

      it "shows invoice id with formatted date and time" do
        visit merchant_path(merchant_3)

        expect("#{invoice_8.id}").to appear_before("#{invoice_7.id}")
      end

      it "displays a link to view all of this merchants coupons" do
        visit merchant_path(merchant_3)

        expect(page).to have_link("My Coupons")

        click_link("My Coupons")

        expect(current_path).to eq(merchant_coupons_path(merchant_3))
      end
    end
  end
end
