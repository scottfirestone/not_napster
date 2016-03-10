require "rails_helper"

RSpec.describe AlbumReview, type: :model do
  it { should belong_to(:review) }
  it { should belong_to(:album) }
end
