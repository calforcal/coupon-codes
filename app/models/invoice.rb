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
    invoice_items.sum("unit_price * quantity")
  end
end
