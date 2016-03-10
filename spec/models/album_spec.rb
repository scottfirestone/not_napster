require "rails_helper"

RSpec.describe Album, type: :model do
  it { should belong_to(:genre) }
  it { should belong_to(:artist) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:slug) }
  it { should validate_uniqueness_of(:slug) }
  it { should validate_uniqueness_of(:title).scoped_to(:artist_id) }

  it "randomly chooses albums for discovery" do
    8.times { FactoryGirl.create(:album) }

    random_albums = Album.discovery(4)

    expect(random_albums.length).to eq(4)
  end

  it "knows if its expired based on expiry date" do
    album = FactoryGirl.create(:album)

    expect(album.expired?).to eq(false)

    album.update(expiry_date: "#{Time.now - 1.month}")

    expect(album.expired?).to eq(true)
  end

  it "knows its status based on expiration date" do
    album = FactoryGirl.create(:album)

    expect(album.status).to eq("Valid")

    album.update(expiry_date: "#{Time.now - 1.month}")

    expect(album.status).to eq("Expired")
  end
end
