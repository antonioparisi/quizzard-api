class User < ActiveRecord::Base
  validates :email, :name, :lastname, :picture, :access_token, :presence => true

  def picture=(uid)
    write_attribute :picture, "http://graph.facebook.com/#{uid}/picture" if uid.to_i != 0
    write_attribute :picture, uid.to_s if uid.to_i == 0
  end

  def fullname
    [name, lastname].join(' ')
  end
end
