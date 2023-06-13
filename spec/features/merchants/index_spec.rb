require "rails_helper"

RSpec.describe "/merchants" do
  describe "As a visitor" do
    describe "when I visit a merchants index page" do
      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant) }

      it "displays each merchants name as a link" do
        visit "/merchants"
        
        expect(page).to have_link(merchant_1.name)
        expect(page).to have_link(merchant_2.name)
      end
    end
  end
end