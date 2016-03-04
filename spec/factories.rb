FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "User #{n}" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password "password"
  end

  factory :artist do
    sequence(:name) { |n| "Artist #{n}" }
    image_url "http://cdn.pitchfork.com/albums/18689/homepage_large.111d1a3b.jpg"

    factory :artist_with_albums do
      transient do
        albums_count 3
      end

      after(:create) do |artist, evaluator|
        create_list(:album, evaluator.albums_count, artist: artist)
      end
    end
  end

  factory :genre do
    sequence(:name, ["Musak", "New Age"].cycle) { |n| n }
  end

  factory :album do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    release_year "1994"
    image_url "http://cdn.pitchfork.com/albums/18689/homepage_large.111d1a3b.jpg"
    price 100
    artist
  end
end
