class PublicCarrier < ActiveRecord::Base
  attr_accessible :authenticate, :ip, :name, :port, :sip_pass, :sip_user, :sip_profile_id

  validates :name, :presence => true
  validates :ip, :format => { :with => /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/, :message => "IP invalida"}
  validates :port, :numericality => {:only_integer => true}
  validates :sip_profile_id, :presence => true
  has_many :public_cash_plans , :dependent => :destroy
  belongs_to :sip_profile
  belongs_to :freeswitch
  
  def realm
    r = ip.to_s
    p = self.port > 0 ? self.port: 5060
    r + ":" + p.to_s
  end

  def context
    '%s-context' % name
  end
  
end
