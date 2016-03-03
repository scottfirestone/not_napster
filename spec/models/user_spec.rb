require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username).is_at_least(6) }
  it { should validate_uniqueness_of(:username) }

  it { should validate_presence_of(:email) }
  it { should allow_value("example@example.com").for(:email) }
  it { should_not allow_value("foo").for(:email) }
  it { should validate_uniqueness_of(:email) }
end
