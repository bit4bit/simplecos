class Consumers::RequestCash < ActiveRecord::Base
  attr_accessible :amount, :client_id, :note
  belongs_to :client
end
