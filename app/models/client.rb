require 'digest/sha2'

class Client < ActiveRecord::Base
  attr_accessible :balance, :name, :public_carrier_id, :sip_pass, :sip_user, :max_calls, :proxy_media, :bypass_media
  has_many :client_cashs, :dependent => :destroy
  has_many :client_cash_plans, :dependent => :destroy

  belongs_to :public_carrier
  validates :password, :presence => true, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  validates :name, :presence => true
  validates :public_carrier_id, :presence => true, :numericality => true
  validates :max_calls, :presence => true, :numericality => true

  devise :database_authenticatable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  before_destroy { |record| Consumers::RequestCash.destroy_all :client_id => record.id}
  def total_amount
    total = 0
    client_cashs.all.each{|cc| total += cc.amount}
    total
  end
end
