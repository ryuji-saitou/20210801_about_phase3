class PostImage < ApplicationRecord
  attachment :image

  belongs_to :post
end
