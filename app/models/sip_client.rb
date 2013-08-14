class SipClient < ActiveRecord::Base
  belongs_to :client_id
  attr_accessible :max_calls, :proxy_media, :sip_pass, :sip_user
end
