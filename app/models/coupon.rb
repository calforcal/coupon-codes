class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  
  enum status: ["activated", "deactivated"] # activated = 0, deactivated = 1
  enum coupon_type: ["percent", "dollars"] # percent = 0, dollars = 1

end