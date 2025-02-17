require "date"

class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :coupon, optional: true

  validates_presence_of :status

  enum status: ["cancelled", "completed", "in progress"] # can = 0 com = 1 in p = 2 need to remigrate and make integers

  #class methods
  def self.incomp_invoices
    Invoice.joins(:invoice_items).where("invoice_items.status != ?", 1).order(created_at: :asc, id: :asc).distinct
  end
  
  #instance methods
  def revenue
    (invoice_items.sum("unit_price * quantity") / 100.0).round(2)
  end

  def ineligible_item?
    items.where('items.merchant_id != ?', coupon.merchant_id).any?
  end

  def grand_total
    if coupon == nil || ineligible_item?
      total = revenue
    elsif coupon.coupon_type == "percent"
      discount = 1 - coupon.money_off.to_f / 100
      total = (revenue * discount).round(2)
    elsif coupon.coupon_type == "dollars"
      total = (revenue - coupon.money_off / 100).round(2)
    end

    if total < 0
      0
    else
      total
    end
  end
end