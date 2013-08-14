class ClientCash < ActiveRecord::Base
  attr_accessible :amount, :client_id, :created_at
  validates :client_id, :presence => true
  validates :amount, :numericality => {:only_integer => true}
  belongs_to :client

  before_update :save_last_amount
  after_update :increment_balance_difference
  after_create :increment_balance
  
  protected
  @last_amount = 0
  def save_last_amount
    @last_amount = ClientCash.find(self.id).amount
  end

  def increment_balance_difference
    self.client.increment!(:balance, self.amount - @last_amount)
    @last_amount = 0
  end
  
  def increment_balance 
    self.client.increment!(:balance, self.amount)
  end
end
