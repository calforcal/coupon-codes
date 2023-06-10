require "rails_helper"

RSpec.describe "/merchants/:id/items/new" do
  describe "As a visitor" do
    describe "when I am redirected to a new item form" do
      let!(:merchant_1) { create(:merchant) }

      it "displays a form to create a new item" do
        visit new_merchant_item_path(merchant_1)

        expect(page).to have_content("Create New Item")
        fill_in("Name:", with: "The New Black")
        fill_in("Description:", with: "The Newer Black")
        fill_in("Unit Price:", with: 66666)
        fill_in("Status:", with: "disabled")

        click_button "Submit New Item"

        expect(current_path).to eq(merchant_items_path(merchant_1))
        within ".disabled-items" do
          expect(page).to have_content("The New Black")
        end
        click_link "The New Black"
        expect(page).to have_content("Item Name: The New Black")
        expect(page).to have_content("Item Description: The Newer Black")
        expect(page).to have_content("Current Selling Price: $666.66")
      end

      it "will flash an error message if the form fields are not filled out" do
        visit new_merchant_item_path(merchant_1)

        click_button "Submit New Item"
        expect(current_path).to eq(new_merchant_item_path(merchant_1))
        expect(page).to have_content("Please fill out all fields")
      end
    end
  end
end