require "rails_helper"

RSpec.describe Order, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:albums) }
  it { should have_many(:order_albums) }

  it "has a formatted total" do
    order = Order.create(total: 500)

    formatted_total = order.formatted_total

    expect(formatted_total).to eq("5.00")
  end
end
