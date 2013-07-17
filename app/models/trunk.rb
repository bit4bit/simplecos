class Trunk < ActiveRecord::Base
  belongs_to :public_carrier
  attr_accessible :authenticate, :bridge, :ip, :name, :port, :sip_pass, :sip_user, :public_carrier_id, :weight

  validates :name, :presence => true
  validates :ip, :format => { :with => /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/, :message => "IP invalida"}, :presence => true
  validates :port, :numericality => {:only_integer => true}
  validates :public_carrier_id, :presence => true

  def realm
    r = ip.to_s
    p = self.port.to_i > 0 ? self.port: 5060
    r + ":" + p.to_s
  end

end
