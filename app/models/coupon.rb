class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates :code, uniqueness: true
  
  enum status: ["activated", "deactivated"] # activated = 0, deactivated = 1
  enum coupon_type: ["percent", "dollars"] # percent = 0, dollars = 1

  def times_used
    invoices.joins(:transactions).count('transactions.result = 0')
  end
end