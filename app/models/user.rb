class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_id, :roles, :role_ids
  has_and_belongs_to_many :roles

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  # attr_accessible :title, :body
end
