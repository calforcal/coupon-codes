class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  
  enum status: ["enabled", "disabled"] # enabled = 0, disabled = 1
  
end