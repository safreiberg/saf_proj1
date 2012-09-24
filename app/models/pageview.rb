class Pageview < ActiveRecord::Base
  attr_accessible :hittime, :location, :site_id

  validates :hittime, :presence => true
  validates :location, :presence => true
  validates :site_id, :presence => true
end
