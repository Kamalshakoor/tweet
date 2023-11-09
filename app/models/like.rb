class Like < ApplicationRecord
  belongs_to :user
  belongs_to :twet
  validates_uniqueness_of :user_id, scope: :twet_id
end
