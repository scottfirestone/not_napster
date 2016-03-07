class Genre < ActiveRecord::Base
  has_many :albums

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  def to_param
    slug
  end
end
