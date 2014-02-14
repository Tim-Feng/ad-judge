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
    self.down_votes.to_f / self.total_votes.to_f * 100
  end

  def user_vote(user)
    self.votes.find_by(user_id: user.id)
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end
end