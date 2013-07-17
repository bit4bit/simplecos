class PublicCarrier < ActiveRecord::Base
  attr_accessible :name, :sip_profile_id

  validates :name, :presence => true
  validates :sip_profile_id, :presence => true

  has_many :public_cash_plans , :dependent => :destroy
  has_many :trunks
  belongs_to :sip_profile
  belongs_to :freeswitch
  
  def context
    '%s-context' % name
  end
  
  #Public: Para manejo de prioridad en las troncales.
  #
  #Return Integer peso total para distribucion
  def total_weight
    total = 0
    trunks.each do |trunk|
      total += trunk.weight ? trunk.weight : 1
    end
    total
  end

  #Public: cadena de texto para ser usada en la marcacion de freeswitch{bridge}.
  #
  #Return String cade de texto para bridge
  def to_bridge
    "${distributor(#{name})}"
  end
end
