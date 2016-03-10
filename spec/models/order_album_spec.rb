require "rails_helper"

RSpec.describe OrderAlbum, type: :model do
  it { should belong_to(:order) }
  it { should belong_to(:album) }

  it "has a title" do
    allow_any_instance_of(Album).to receive(:title).and_return("Title")
  end
end
