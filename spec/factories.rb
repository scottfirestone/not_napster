FactoryGirl.define do
  factory :genre do
    sequence(:name, ["Musak", "New Age"].cycle) { |n| n }
  end

  factory :album do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    release_year "1994"
    image_url "http://cdn.pitchfork.com/albums/18689/homepage_large.111d1a3b.jpg"
    sequence(:price) { |n| n + 99 }
  end
end
