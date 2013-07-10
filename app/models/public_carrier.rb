class PublicCarrier < ActiveRecord::Base
  attr_accessible :authenticate, :ip, :name, :port, :sip_pass, :sip_user, :freeswitch_id

  validates :name, :presence => true
  validates :ip, :format => { :with => /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/, :message => "IP invalida"}
  validates :port, :numericality => {:only_integer => true}

  has_many :public_cash_plans , :dependent => :destroy
  belongs_to :freeswitch

  def context
    '%s-context' % name
  end
  
end
