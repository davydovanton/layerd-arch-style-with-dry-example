# frozen_string_literal: true

# require 'features_helper' # i didn't create this file

# IMPORTANT: just for example of e2e or integration (feature specs)

RSpec.describe 'FEATURE: Checkout ful business flow', type: :feature do
  let(:url) { '/' }

  # let(:account) { Fabricate(:account) }
  # let(:order) { Fabricate(:order, account_id: account.id) }

  before do
    # Fabricate(:item, order_id: order.id)
    # Fabricate(:item, order_id: order.id)
    # Fabricate(:item, order_id: order.id)
  end

  it 'completes for valid order' do
    # visit "/order/#{order.id}"
    # click_button "Checkout order"
    # expect(page).to have_text("Order was payed")
  end
end
