class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password

  validates :password, :presence => true, :on => :create
  validates :email, :presence => true

  def changePassword(p)
    self.password = p
    self.save
  end

end
