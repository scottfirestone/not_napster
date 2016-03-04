class Genre < ActiveRecord::Base
  has_many :albums

  validates :slug, presence: true

  def to_param
    slug
  end
end
