class TwitterHandle < ActiveRecord::Base
  has_many :keywords
  has_one :post
end
