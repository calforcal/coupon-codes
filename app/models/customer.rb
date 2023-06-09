class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name, :last_name

  #class methods
  def self.top_customers(limit)
    joins(invoices: :transactions).select("customers.*, COUNT(transactions.id) as transactions_count").where(transactions: {result:0}).group("customers.id").order("transactions_count DESC").order(:last_name,:first_name).limit(limit)
  end

  #instance methods
  def customer_success_trans
    self.transactions.where(result:"success").count
  end
end
