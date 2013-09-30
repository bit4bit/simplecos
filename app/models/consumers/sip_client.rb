class Consumers::SipClient < ::SipClient
  validates :sip_user, :presence => true
  validates :sip_pass, :presence => true
end

