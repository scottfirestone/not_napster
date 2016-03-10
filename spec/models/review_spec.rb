require "rails_helper"

RSpec.describe Review, type: :model do
  it { should validate_presence_of(:comment) }
  it { should have_many(:albums) }
  it { should have_many(:album_reviews) }
end
