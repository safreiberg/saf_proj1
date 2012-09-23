class Site < ActiveRecord::Base
  # Each site has a name and a hitcount. Both should always be present.
  attr_accessible :name, :hits, :total_duration, :isopen, :ownedby

  has_many :pages

  validates :name, :presence => true
  validates :hits, :presence => true
  validates :total_duration, :presence => true
  validates :isopen, :presence => true
  validates :ownedby, :presence => true

  def increaseHitCount
    self.hits = self.hits + 1
    self.save
  end

  def increaseTotalDuration(dur)
    self.total_duration = self.total_duration + dur
    self.save
  end

  def makePublic
    self.isopen = true
    self.save
  end

  def makeNotPublic
    self.isopen = false
    self.save
  end
end
