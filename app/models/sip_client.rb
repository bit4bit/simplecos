class SipClient < ActiveRecord::Base
  belongs_to :client
  attr_accessible :max_calls, :proxy_media, :sip_pass, :sip_user, :client_id, :caller_name, :caller_number

  validate :max_calls, :numericality => {:only_integer => true}
  validate :proxy_media, :presence => true
  

  def caller_name
    return self.sip_user if read_attribute(:caller_name).empty?
    read_attribute(:caller_name)
  end
  
  def proxy_media_bypass?
    self.proxy_media == 'bypass'
  end

  def proxy_media_proxy?
    self.proxy_media == 'media'
  end
end
