class Consumers::RequestCash < ActiveRecord::Base
  attr_accessible :amount, :client_id, :note
  validates :amount, :numericality => {:only_integer => true, :greater_than => 999}

  belongs_to :client
end
