require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many :coupons }
  end

  context "validations" do
    it {should validate_presence_of(:name)}
  end

  describe "#class methods" do
    it "can filter records by enabled" do
      @merchant_1 = create(:merchant, status: 0)
      @merchant_2 = create(:merchant, status: 0)
      @merchant_3 = create(:merchant, status: 1)
      @merchant_4 = create(:merchant, status: 0)
      @merchant_5 = create(:merchant, status: 0)

      original = [@merchant_1, @merchant_2, @merchant_3, @merchant_4, @merchant_5]
      expected = [@merchant_1, @merchant_2, @merchant_4, @merchant_5]

      expect(Merchant.all).to eq(original)
      expect(Merchant.filter_enabled).to eq(expected)
    end

    it "can filter records by disabled" do
      @merchant_1 = create(:merchant, status: 0)
      @merchant_2 = create(:merchant, status: 0)
      @merchant_3 = create(:merchant, status: 1)
      @merchant_4 = create(:merchant, status: 0)
      @merchant_5 = create(:merchant, status: 0)
      original = [@merchant_1, @merchant_2, @merchant_3]
      original = [@merchant_1, @merchant_2, @merchant_3, @merchant_4, @merchant_5]
      expected = [@merchant_3]

      expect(Merchant.all).to eq(original)
      expect(Merchant.filter_disabled).to eq(expected)
    end

    describe "#methods" do
      let!(:merchant_1) { create(:merchant, status: 0) }
      let!(:item_1) { create(:item, merchant_id: merchant_1.id)}
      let!(:item_2) { create(:item, merchant_id: merchant_1.id)}
      let!(:item_3) { create(:item, merchant_id: merchant_1.id)}

      let!(:merchant_2) { create(:merchant, status: 0) }
      let!(:item_4) { create(:item, merchant_id: merchant_2.id)}
      let!(:item_5) { create(:item, merchant_id: merchant_2.id)}
      let!(:item_6) { create(:item, merchant_id: merchant_2.id)}

      let!(:merchant_3) { create(:merchant, status: 0) }
      let!(:item_7) { create(:item, merchant_id: merchant_3.id)}
      let!(:item_8) { create(:item, merchant_id: merchant_3.id)}
      let!(:item_9) { create(:item, merchant_id: merchant_3.id)}

      let!(:merchant_4) { create(:merchant, status: 1) }
      let!(:item_10) { create(:item, merchant_id: merchant_4.id)}
      let!(:item_11) { create(:item, merchant_id: merchant_4.id)}
      let!(:item_12) { create(:item, merchant_id: merchant_4.id)}

      let!(:merchant_5) { create(:merchant, status: 1) }
      let!(:item_13) { create(:item, merchant_id: merchant_5.id)}
      let!(:item_14) { create(:item, merchant_id: merchant_5.id)}
      let!(:item_15) { create(:item, merchant_id: merchant_5.id)}

      let!(:merchant_6) { create(:merchant, status: 1) }
      let!(:item_16) { create(:item, merchant_id: merchant_6.id)}
      let!(:item_17) { create(:item, merchant_id: merchant_6.id)}
      let!(:item_18) { create(:item, merchant_id: merchant_6.id)}

      let!(:customer_1) { create(:customer) }
      let!(:customer_2) { create(:customer) }
      let!(:customer_3) { create(:customer) }
      let!(:customer_4) { create(:customer) }
      let!(:customer_5) { create(:customer) }
      let!(:customer_6) { create(:customer) }

      let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 1) }
      let!(:invoice_2) { create(:invoice, customer_id: customer_1.id, status: 1) }
      let!(:invoice_3) { create(:invoice, customer_id: customer_1.id, status: 1) }

      let!(:invoice_4) { create(:invoice, customer_id: customer_2.id, status: 1) }
      let!(:invoice_5) { create(:invoice, customer_id: customer_2.id, status: 1) }
      let!(:invoice_6) { create(:invoice, customer_id: customer_2.id, status: 1) }

      let!(:invoice_7) { create(:invoice, customer_id: customer_3.id, status: 1) }
      let!(:invoice_8) { create(:invoice, customer_id: customer_3.id, status: 1) }
      let!(:invoice_9) { create(:invoice, customer_id: customer_3.id, status: 1) }

      let!(:invoice_10) { create(:invoice, customer_id: customer_4.id, status: 1) }
      let!(:invoice_11) { create(:invoice, customer_id: customer_4.id, status: 1) }
      let!(:invoice_12) { create(:invoice, customer_id: customer_4.id, status: 1) }

      let!(:invoice_13) { create(:invoice, customer_id: customer_5.id, status: 1) }
      let!(:invoice_14) { create(:invoice, customer_id: customer_5.id, status: 1) }
      let!(:invoice_15) { create(:invoice, customer_id: customer_5.id, status: 1) }

      let!(:invoice_16) { create(:invoice, customer_id: customer_6.id, status: 1, created_at: "2023-05-20 07:45:12.82345") }
      let!(:invoice_17) { create(:invoice, customer_id: customer_6.id, status: 1, created_at: "2023-03-06 01:49:45.21235") }
      let!(:invoice_18) { create(:invoice, customer_id: customer_6.id, status: 1, created_at: "2023-01-05 21:16:07.11835") }

      let!(:invoice_item_1) { create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 100000, quantity: 1) }
      let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: 100000, quantity: 1) }
      let!(:invoice_item_3) { create(:invoice_item, invoice: invoice_3, item: item_3, unit_price: 100000, quantity: 1) }
      let!(:invoice_item_4) { create(:invoice_item, invoice: invoice_4, item: item_4, unit_price: 200000, quantity: 1) }
      let!(:invoice_item_5) { create(:invoice_item, invoice: invoice_5, item: item_5, unit_price: 200000, quantity: 1) }
      let!(:invoice_item_6) { create(:invoice_item, invoice: invoice_6, item: item_6, unit_price: 200000, quantity: 1) }
      let!(:invoice_item_7) { create(:invoice_item, invoice: invoice_7, item: item_7, unit_price: 10, quantity: 1) }
      let!(:invoice_item_8) { create(:invoice_item, invoice: invoice_8, item: item_8, unit_price: 10, quantity: 1) }
      let!(:invoice_item_9) { create(:invoice_item, invoice: invoice_9, item: item_9, unit_price: 10, quantity: 1) }
      let!(:invoice_item_10) { create(:invoice_item, invoice: invoice_10, item: item_10, unit_price: 300000, quantity: 1) }
      let!(:invoice_item_11) { create(:invoice_item, invoice: invoice_11, item: item_11, unit_price: 300000, quantity: 1) }
      let!(:invoice_item_12) { create(:invoice_item, invoice: invoice_12, item: item_12, unit_price: 300000, quantity: 1) }
      let!(:invoice_item_13) { create(:invoice_item, invoice: invoice_13, item: item_13, unit_price: 400000, quantity: 1) }
      let!(:invoice_item_14) { create(:invoice_item, invoice: invoice_14, item: item_14, unit_price: 400000, quantity: 1) }
      let!(:invoice_item_15) { create(:invoice_item, invoice: invoice_15, item: item_15, unit_price: 400000, quantity: 1) }
      let!(:invoice_item_16) { create(:invoice_item, invoice: invoice_16, item: item_16, unit_price: 500000, quantity: 1) }
      let!(:invoice_item_17) { create(:invoice_item, invoice: invoice_17, item: item_17, unit_price: 500000, quantity: 1) }
      let!(:invoice_item_18) { create(:invoice_item, invoice: invoice_18, item: item_18, unit_price: 500000, quantity: 1) }
      let!(:invoice_item_19) { create(:invoice_item, invoice: invoice_18, item: item_18, unit_price: 500000, quantity: 1) }

      let!(:transaction_1) { create(:transaction, invoice: invoice_1, result: 0) }
      let!(:transaction_2) { create(:transaction, invoice: invoice_2, result: 0) }
      let!(:transaction_3) { create(:transaction, invoice: invoice_3, result: 0) }
      let!(:transaction_4) { create(:transaction, invoice: invoice_4, result: 0) }
      let!(:transaction_5) { create(:transaction, invoice: invoice_5, result: 0) }
      let!(:transaction_6) { create(:transaction, invoice: invoice_6, result: 0) }
      let!(:transaction_7) { create(:transaction, invoice: invoice_7, result: 0) }
      let!(:transaction_8) { create(:transaction, invoice: invoice_8, result: 0) }
      let!(:transaction_9) { create(:transaction, invoice: invoice_9, result: 0) }
      let!(:transaction_10) { create(:transaction, invoice: invoice_10, result: 0) }
      let!(:transaction_11) { create(:transaction, invoice: invoice_11, result: 0) }
      let!(:transaction_12) { create(:transaction, invoice: invoice_12, result: 0) }
      let!(:transaction_13) { create(:transaction, invoice: invoice_13, result: 0) }
      let!(:transaction_14) { create(:transaction, invoice: invoice_14, result: 0) }
      let!(:transaction_15) { create(:transaction, invoice: invoice_15, result: 0) }
      let!(:transaction_16) { create(:transaction, invoice: invoice_16, result: 0) }
      let!(:transaction_17) { create(:transaction, invoice: invoice_17, result: 0) }
      let!(:transaction_18) { create(:transaction, invoice: invoice_18, result: 0) }

      it "can return the top 5 merchants by revenue" do
        original = [merchant_1, merchant_2, merchant_3, merchant_4, merchant_5, merchant_6]
        expected = [merchant_6, merchant_5, merchant_4, merchant_2, merchant_1]

        expect(Merchant.all).to eq(original)
        expect(Merchant.top_5_by_revenue).to eq(expected)
      end

      it "can return a single merchants best day in revenue" do
        expect(merchant_6.best_day).to eq(invoice_18.created_at.to_datetime.strftime("%Y-%m-%d"))
      end
    end
  end

  describe "instance methods" do
    before(:each) do
      @merchant_1 = create(:merchant, status: 0)
      @merchant_2 = create(:merchant, status: 0)
      @merchant_3 = create(:merchant, status: 1)
      @merchant_4 = create(:merchant, status: 0)
      @merchant_5 = create(:merchant, status: 0)
    end

    # let!(:merchant_4) { create(:merchant, status: 0) }
    # let!(:merchant_5) { create(:merchant, status: 0) }

    let!(:customer_1) { create(:customer) }
    let!(:customer_2) { create(:customer) }
    let!(:customer_3) { create(:customer) }
    let!(:customer_4) { create(:customer) }
    let!(:customer_5) { create(:customer) }
    let!(:customer_6) { create(:customer) }
    let!(:customer_7) { create(:customer) }

    let!(:item_1) { create(:item, merchant_id: @merchant_4.id) }
    let!(:item_2) { create(:item, merchant_id: @merchant_4.id) }
    let!(:item_3) { create(:item, merchant_id: @merchant_4.id) }
    let!(:item_4) { create(:item, merchant_id: @merchant_4.id) }
    let!(:item_5) { create(:item, merchant_id: @merchant_5.id) }

    let!(:invoice_item_1) { create(:invoice_item, unit_price: 2000, invoice_id: invoice_1.id, item_id: item_1.id) }
    let!(:invoice_item_2) { create(:invoice_item, unit_price: 3000, invoice_id: invoice_2.id, item_id: item_2.id) }
    let!(:invoice_item_3) { create(:invoice_item, unit_price: 4000, invoice_id: invoice_3.id, item_id: item_3.id) }
    let!(:invoice_item_4) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_4.id, item_id: item_4.id) }
    let!(:invoice_item_5) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_5.id, item_id: item_3.id) }
    let!(:invoice_item_6) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_6.id, item_id: item_3.id) }
    let!(:invoice_item_7) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_7.id, item_id: item_2.id) }
    let!(:invoice_item_7) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_8.id, item_id: item_5.id) }

    let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 0)}
    let!(:invoice_2) { create(:invoice, customer_id: customer_2.id, status: 0)}
    let!(:invoice_3) { create(:invoice, customer_id: customer_2.id, status: 0)}
    let!(:invoice_4) { create(:invoice, customer_id: customer_3.id, status: 0)}
    let!(:invoice_5) { create(:invoice, customer_id: customer_4.id, status: 0)}
    let!(:invoice_6) { create(:invoice, customer_id: customer_5.id, status: 0)}
    let!(:invoice_7) { create(:invoice, customer_id: customer_4.id, status: 0)}
    let!(:invoice_8) { create(:invoice, customer_id: customer_6.id, status: 0)}

    let!(:transaction_1) { create(:transaction, invoice_id: invoice_1.id, result: 0) }
    let!(:transaction_2) { create(:transaction, invoice_id: invoice_2.id, result: 0) }
    let!(:transaction_3) { create(:transaction, invoice_id: invoice_3.id, result: 0) }
    let!(:transaction_4) { create(:transaction, invoice_id: invoice_4.id, result: 0) }
    let!(:transaction_5) { create(:transaction, invoice_id: invoice_5.id, result: 0) }
    let!(:transaction_6) { create(:transaction, invoice_id: invoice_6.id, result: 0) }
    let!(:transaction_7) { create(:transaction, invoice_id: invoice_7.id, result: 0) }
    let!(:transaction_8) { create(:transaction, invoice_id: invoice_8.id, result: 1) }

    let!(:coupon_1) { @merchant_3.coupons.create!(name: "50% off", code: "GET50", coupon_type: 0, status: 0, money_off: 50) }
    let!(:coupon_2) { @merchant_3.coupons.create!(name: "$10 off", code: "TAKE10", coupon_type: 1, status: 0, money_off: 10) }
    let!(:coupon_3) { @merchant_3.coupons.create!(name: "25% off", code: "GET25", coupon_type: 0, status: 0, money_off: 25) }

    describe "#top_5_customers" do
      it "merchant can find number of successfull customer transactions" do
        have = [customer_2, customer_4, customer_1, customer_3, customer_5]
        not_have= [customer_6, customer_7]
        expect(@merchant_4.top_5_customers).to eq(have)
      end
    end

    describe "#unique_invoices" do
      it "merchant can find number of unique invoices" do
        expect(@merchant_4.unique_invoices.count).to eq(6)
      end
    end

    describe "#total_active_coupons" do
      it "returns the total number of active coupons for a merchant" do
        expect(@merchant_3.total_active_coupons).to eq(3)
      end
    end
  end
end
