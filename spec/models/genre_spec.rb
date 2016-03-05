require "rails_helper"

RSpec.describe Genre, type: :model do
  it { should have_many(:albums) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }
end
