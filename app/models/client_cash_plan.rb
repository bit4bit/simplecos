class ClientCashPlan < ActiveRecord::Base
  attr_accessible :bill_minimum, :bill_rate, :bridge, :client_id, :expression, :public_carrier_id, :name, :note
  belongs_to :client
  belongs_to :public_carrier

  validates :public_carrier_id, :presence => true
  validates :client_id, :presence => true
  validates :expression, :presence => true
  validates :bill_rate, :numericality => true
  validates :bill_minimum, :numericality => true
end
