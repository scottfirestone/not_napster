require "rails_helper"

RSpec.describe OrderAlbum, type: :model do
  it { should belong_to(:order) }
  it { should belong_to(:album) }
  it { should validate_presence_of(:quantity) }
end
