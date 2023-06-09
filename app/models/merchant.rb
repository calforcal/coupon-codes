class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :coupons

  validates_presence_of :name

  def top_5_customers
    customers.joins(:transactions).select("customers.*, COUNT(transactions.id) as transaction_count").where(transactions: {result: "success"}).group("customers.id").order("transaction_count DESC").limit(5)
  end

  enum status: ["enabled", "disabled"] # enabled = 0, disabled = 1

  def self.filter_enabled
    Merchant.where(status: "enabled")
  end

  def self.filter_disabled
    Merchant.where(status: "disabled")
  end

  def self.top_5_by_revenue
    top_5 = joins(items: [{invoice_items: { invoice: :transactions } }]).select('merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as revenue').where('transactions.result = 0').group(:id).order('revenue DESC').limit(5)
  end

  def unique_invoices
    self.invoices.distinct
  end

  def best_day
    day = invoice_items.joins(invoice: :transactions).select('invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue').where('transactions.result = 0').group('invoices.id').order('revenue desc').limit(1).first.created_at
    day.to_datetime.strftime("%Y-%m-%d")
  end
end
