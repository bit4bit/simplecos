class Freeswitch < ActiveRecord::Base
  attr_accessible :ip, :name
  validates :ip, :format => { :with => /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/, :message => "IP invalida"}, :uniqueness => true
  validates :name, :presence => true

  has_many :sip_profiles, :dependent => :destroy
end
