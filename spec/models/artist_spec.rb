require "rails_helper"

RSpec.describe Artist, type: :model do
  it { should have_many(:albums) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }
end
