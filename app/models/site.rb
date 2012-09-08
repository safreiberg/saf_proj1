class Site < ActiveRecord::Base
  # Each site has a name and a hitcount. Both should always be present.
  attr_accessible :name, :hits

  validates :name, :presence => true
  validates :hits, :presence => true

  def increaseHitCount
    self.hits = self.hits + 1
    self.save
  end
end
