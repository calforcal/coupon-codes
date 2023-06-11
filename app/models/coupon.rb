class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates :code, uniqueness: true
  
  enum status: ["activated", "deactivated"] # activated = 0, deactivated = 1
  enum coupon_type: ["percent", "dollars"] # percent = 0, dollars = 1

  def times_used
    invoices.joins(:transactions).where("transactions.result = 0").count
  end

  def pending_invoices?
    invoices.where("invoices.status = 2").any?
  end

  def self.activated_coupons
    where('status = 0')
  end

  def self.deactivated_coupons
    where('status = 1')
  end
end