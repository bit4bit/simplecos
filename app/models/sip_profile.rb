class SipProfile < ActiveRecord::Base
  belongs_to :freeswitch
  attr_accessible :inbound_codec, :name, :outbound_codec, :rtp_ip, :sip_ip, :sip_port, :freeswitch_id

  validates :name, :presence => true
  validates :rtp_ip, :presence => true
  validates :sip_ip, :presence => true
  validates :sip_port, :presence => true
  validates :sip_port, :numericality => {:only_integer => true}
  validates :freeswitch_id, :presence => true

  has_many :public_carriers
end
