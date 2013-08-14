class SipClient < ActiveRecord::Base
  belongs_to :client
  attr_accessible :max_calls, :proxy_media, :sip_pass, :sip_user, :client_id

  def proxy_media_bypass?
    self.proxy_media == 'bypass'
  end

  def proxy_media_proxy?
    self.proxy_media == 'media'
  end
end
