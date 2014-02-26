module Voteable
  extend ActiveSupport::Concern

  include do
    has_many :votes, as: :Voteable
  end

  def total_votes
    self.up_votes + self.down_votes
  end

  def up_ratio
    self.up_votes.to_f / self.total_votes.to_f * 100
  end

  def down_ratio
    (100 - up_ratio).to_f
  end

  def user_vote(user)
    self.votes.find_by(user_id: user.id)
  end
end