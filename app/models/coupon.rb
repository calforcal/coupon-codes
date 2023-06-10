class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  
  enum status: ["activated", "deactivated"] # activated = 0, deactivated = 1

end