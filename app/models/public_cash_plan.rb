class PublicCashPlan < ActiveRecord::Base
  attr_accessible :bill_rate, :expression, :public_carrier_id, :bill_minimum, :bridge, :name, :note
  belongs_to :public_carrier
  validates :public_carrier_id, :presence => true
  validates :expression, :presence => true
  validates :bill_rate, :numericality => true
end
