class Vote < ApplicationRecord
  enum vote_status: [ :collecting, :voting, :archived ]
  enum vote_type: [ :multi ]
  belongs_to :user
  has_many_attached :pictures
end
