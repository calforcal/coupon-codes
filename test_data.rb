# class CreateCustomer < ActiveRecord::Migration[7.0]
#   def change
#     create_table :customers do |t|
#       t.string :first_name
#       t.string :last_name
#       t.string :created_at
#       t.string :updated_at
#     end
#   end
# end


# class CreateMerchants < ActiveRecord::Migration[7.0]
#   def change
#     create_table :merchants do |t|
#       t.string :name
#       t.string :created_at
#       t.string :updated_at
#     end
#   end
# end


# class CreateInvoices < ActiveRecord::Migration[7.0]
#   def change
#     create_table :invoices do |t|
#       t.string :status
#       t.string :created_at
#       t.string :updated_at
#     end
#     add_reference :invoices, :customer, foreign_key: true
#   end
# end


# class CreateItems < ActiveRecord::Migration[7.0]
#   def change
#     create_table :items do |t|
#       t.string :name
#       t.string :description
#       t.integer :unit_price
#       t.string :created_at
#       t.string :updated_at
#     end
#     add_reference :items, :merchant, foreign_key: true
#   end
# end


# class CreateInvoiceItems < ActiveRecord::Migration[7.0]
#   def change
#     create_table :invoice_items do |t|
#       t.integer :quantity
#       t.integer :unit_price
#       t.string :status
#       t.string :created_at
#       t.string :updated_at
#     end
#     add_reference :invoice_items, :item, foreign_key: true
#     add_reference :invoice_items, :invoice, foreign_key: true
#   end
# end


# class CreateTransactions < ActiveRecord::Migration[7.0]
#   def change
#     create_table :transactions do |t|
#       t.string :credit_card_number
#       t.string :credit_card_expiration_date
#       t.string :result
#       t.string :created_at
#       t.string :updated_at
#     end
#     add_reference :transactions, :invoice, foreign_key: true
#   end
# end

# @merchant = create(:merchant)
# @item = create(:item, merchant_id: @merchant.id)
# @item1 = create(:item, merchant_id: @merchant.id)
# @item2 = create(:item, merchant_id: @merchant.id)
# @item3 = create(:item, merchant_id: @merchant.id)
# @item4 = create(:item, merchant_id: @merchant.id)

# @customer = create(:customer)
# @invoice = create(:invoice, customer_id: @customer.id)
# @invoice_item = create(:invoice_item, invoice_id: @invoice.id, item_id: @item.id)
# @transaction = create(:transaction, invoice_id: @invoice.id)


# refactor routes to be path_helpers or whatever they're called...resources?


# <%= form_with model: @item, url: "/merchants/#{@merchant.id}/items/#{@item.id}", method: "patch", local: true do |f| %>
#   <%= f.label :name, "Name:" %>
#   <%= f.text_field :name %>

#   <%= f.label :description, "Description:" %>
#   <%= f.text_field :description %>

#   <%= f.label :unit_price, "Unit Price:" %>
#   <%= f.number_field :unit_price %>

#   <%= f.label :status, "Status:" %>
#   <%= f.text_field :status %>

#   <%= f.submit %>
# <% end %>

# <%= form_with model: @item, url: "/merchants/#{@merchant.id}/items", method: :post, local: true do |f| %>
#   <%= f.label :name, "Name:" %>
#   <%= f.text_field :name %>

#   <%= f.label :description, "Description:" %>
#   <%= f.text_field :description %>

#   <%= f.label :unit_price, "Unit Price:" %>
#   <%= f.number_field :unit_price %>

#   <%= f.label :status, "Status:" %>
#   <%= f.text_field :status %>

#   <%= f.hidden_field :merchant_id, value: @merchant.id %>

#   <%= f.submit "Submit New Item" %>
# <% end %>