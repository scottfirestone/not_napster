require "rails_helper"

RSpec.describe Album, type: :model do
  it { should belong_to(:genre) }
  it { should belong_to(:artist) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:slug) }
end
