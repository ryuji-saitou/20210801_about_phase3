class Report < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  belongs_to :comment

end
