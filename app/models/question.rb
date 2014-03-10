class Question < ActiveRecord::Base
  has_many :answers, :dependent => :destroy


  validates :title, :correct_number, :presence => true
end
