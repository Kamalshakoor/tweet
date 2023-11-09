class Twet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy

    # Add a method to increment the likes count
    def increment_likes_count
      self.increment!(:likes_count)
    end
  
    # Add a method to decrement the likes count
    def decrement_likes_count
      self.decrement!(:likes_count)
    end
end
