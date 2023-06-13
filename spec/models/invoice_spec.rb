require 'rails_helper'

RSpec.describe Invoice, type: :model do

  context "relationship" do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many :transactions }
    it { should belong_to(:coupon).optional }
  end

  context "validations" do
    it { should validate_presence_of :status}
  end

  before(:each) do
    @customer = create(:customer)

    @merchant = create(:merchant)
    @coupon_1 = @merchant.coupons.create!(name: "50% off", code: "GET50", coupon_type: 0, status: 0, money_off: 50)
    @coupon_2 = @merchant.coupons.create!(name: "$10 off", code: "GET10", coupon_type: 1, status: 0, money_off: 1000)

    @merchant_2 = create(:merchant)

    @invoice_1 = create(:invoice, customer_id: @customer.id, status: 1, coupon_id: @coupon_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer.id, status: 1, coupon_id: @coupon_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer.id, status: 1)
    @invoice_4 = create(:invoice, customer_id: @customer.id, status: 1)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)
    @item_3 = create(:item, merchant_id: @merchant.id)
    @item_4 = create(:item, merchant_id: @merchant.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)

    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, unit_price: 1080, quantity: 2, status:1)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id, unit_price: 267, quantity: 3, status:1)
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_3.id, unit_price: 3200, quantity: 1, status:1)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_4.id, unit_price: 124, quantity: 1, status:1)

    @invoice_5 = create(:invoice, customer_id: @customer.id, status: 1, coupon_id: @coupon_1.id)
    @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_5.id, unit_price: 1080, quantity: 2, status:1)
  end

  describe "instance methods" do
    describe "#revenue" do
      it "returns the total revenue for a single invoice" do
        expect(@invoice_1.revenue).to eq(29.61)
        expect(@invoice_2.revenue).to eq(33.24)
      end

      it "applies a coupons discount to the total revenue" do
        expect(@invoice_1.revenue).to eq(29.61)

        expect(@invoice_1.grand_total).to eq(14.81) 

        expect(@invoice_2.grand_total).to eq(23.24)

        expect(@invoice_3.grand_total).to eq(@invoice_3.revenue)
      end

      it "returns 0 if the discount is more than item cost" do
        @coupon_2.update(money_off: 10000)

        expect(@invoice_2.grand_total).to eq(0)
      end

      it "will not apply the discount if the item doesn't belong to the merchant with the coupon" do
        expect(@invoice_5.grand_total).to eq(@invoice_5.revenue)
      end
    end
  end

  describe "class methods" do 
    before(:each) do 
      @customer_2 = create(:customer)
      
      @invoice_5 = create(:invoice, customer_id: @customer.id, status: 2)
      @invoice_6 = create(:invoice, customer_id: @customer.id, status: 2)
      @invoice_7 = create(:invoice, customer_id: @customer.id, status: 2)
      @invoice_8 = create(:invoice, customer_id: @customer_2.id, status: 2)
      @invoice_9 = create(:invoice, customer_id: @customer_2.id, status: 2)
      @invoice_10 = create(:invoice, customer_id: @customer_2.id, status: 2)

      @merchant_2 = create(:merchant)

      @item_5 = create(:item, merchant_id: @merchant_2.id)
      @item_6 = create(:item, merchant_id: @merchant_2.id)
      @item_7 = create(:item, merchant_id: @merchant_2.id)
      @item_8 = create(:item, merchant_id: @merchant_2.id)
      @item_9 = create(:item, merchant_id: @merchant_2.id)
      @item_10 = create(:item, merchant_id: @merchant_2.id)

      @invoice_item_6 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_6.id, unit_price: 124, quantity: 1, status:1)
      @invoice_item_7 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_7.id, unit_price: 124, quantity: 1, status:2)

      @invoice_item_8 = create(:invoice_item, invoice_id: @invoice_6.id, item_id: @item_10.id, unit_price: 124, quantity: 1, status:1)
      @invoice_item_9 = create(:invoice_item, invoice_id: @invoice_6.id, item_id: @item_8.id, unit_price: 124, quantity: 1, status:0)

      @invoice_item_10 = create(:invoice_item, invoice_id: @invoice_7.id, item_id: @item_10.id, unit_price: 124, quantity: 1, status:1)
      @invoice_item_11 = create(:invoice_item, invoice_id: @invoice_7.id, item_id: @item_7.id, unit_price: 124, quantity: 1, status:1)

      @invoice_item_12 = create(:invoice_item, invoice_id: @invoice_8.id, item_id: @item_3.id, unit_price: 124, quantity: 1, status:1)
      @invoice_item_13 = create(:invoice_item, invoice_id: @invoice_9.id, item_id: @item_8.id, unit_price: 124, quantity: 1, status:2)
      @invoice_item_14 = create(:invoice_item, invoice_id: @invoice_10.id, item_id: @item_5.id, unit_price: 124, quantity: 1, status:0)
    end

    describe ".incomp_invoices" do 
      it "returns a list of all invoices that have items that have not shipped" do
        expect(Invoice.incomp_invoices).to eq([@invoice_5, @invoice_6, @invoice_9, @invoice_10])
      end

      it "excludes invoices if all its items have been marked as shipped" do 
        expect(Invoice.incomp_invoices).not_to include(@invoice_1, @invoice_2, @invoice_7, @invoice_8)
      end

      it "excludes invoices that have no items" do 
        expect(@invoice_3.items).to eq([])
        expect(Invoice.incomp_invoices).not_to include(@invoice_3)
        
        expect(@invoice_4.items).to eq([])
        expect(Invoice.incomp_invoices).not_to include(@invoice_4)
      end

      it "sorts invoices by creation date from oldest to newest" do
        expect(Invoice.incomp_invoices).to eq([@invoice_5, @invoice_6, @invoice_9, @invoice_10])

        @invoice_11 = create(:invoice, customer_id: @customer_2.id, status: 2)
        @invoice_item_15 = create(:invoice_item, invoice_id: @invoice_11.id, item_id: @item_5.id, unit_price: 124, quantity: 1, status:0)

        expect(Invoice.incomp_invoices).to eq([@invoice_5, @invoice_6, @invoice_9, @invoice_10, @invoice_11])
      end
    end
  end
end
