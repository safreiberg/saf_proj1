class Page < ActiveRecord::Base
  # Page has the same attributes as Site, except that it belongs to a Site.
  attr_accessible :hits, :id, :site_id, :total_duration

  belongs_to :site

  validates :hits, :presence => true
  validates :id, :presence => true
  validates :site_id, :presence => true
  validates :total_duration, :presence => true

  def increaseHitCount
    self.hits = self.hits + 1
    self.save
  end
end
