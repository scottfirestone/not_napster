FactoryGirl.define do
  factory :review do
    album nil
    comment "MyString"
  end
  factory :user do
    sequence(:username) { |n| "User #{n}" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password "password"
  end

  factory :artist do
    sequence(:name) { |n| "Artist #{n}" }
    image_url "http://cdn.pitchfork.com/albums/18689/homepage_large.111d1a3b.jpg"
    sequence(:slug) { |n| "Artist #{n}".downcase.gsub(/\s/, "-") }

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
    sequence(:slug, ["Musak", "New Age"].cycle) do |n|
      n.downcase.gsub(/\s/, "-")
    end
  end

  factory :album do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    release_year "1994"
    image_url "http://cdn.pitchfork.com/albums/18689/homepage_large.111d1a3b.jpg"
    price 100
    expiry_date (Time.now + 6.months)
    sequence(:slug) { |n| "Title #{n}".downcase.gsub(/\s/, "-") }
    artist
  end
end
