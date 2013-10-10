require 'digest/sha2'

class Client < ActiveRecord::Base
  MAX_RANDOM_ACCOUNTCODE = 1000000

  attr_accessible :balance, :name, :public_carrier_id, :accountcode, :allow_admin_sip_accounts

  has_many :client_cashs, :dependent => :destroy
  has_many :client_cash_plans, :dependent => :destroy
  has_many :sip_clients, :dependent => :destroy
  accepts_nested_attributes_for :sip_clients,:allow_destroy => true
  belongs_to :public_carrier
  validates :password, :presence => true, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  validates :name, :presence => true
  validates :public_carrier_id, :presence => true, :numericality => true
  validates :accountcode, uniqueness: true

  devise :database_authenticatable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :sip_clients_attributes

  
  before_destroy { |record| Consumers::RequestCash.destroy_all :client_id => record.id}
  def total_amount
    total = 0
    client_cashs.all.each{|cc| total += cc.amount}
    total
  end
  
  def allow_admin_sip_accounts?
    allow_admin_sip_accounts>0 ? true : false
  end
  

end
