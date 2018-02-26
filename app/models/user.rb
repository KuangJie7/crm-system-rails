class User < ApplicationRecord
  has_and_belongs_to_many :customers
  has_many :feedbacks

  self.table_name = "crm_users"

  def self.table_name_prefix
    'beary-crm_development.'
  end

  validates :name,
            :presence => {:message => "> 请输入用户名"},
            :uniqueness => {:message => "> 用户名已存在"},
            on: :create
  validates :password,
            :presence => {:message => "> 密码不能为空"},
            :confirmation => {:message => "> 两次密码不匹配"},
            :length => {:minimum => 6,:message => "> 密码最短为6位数"},
            on: :create
  validates :password_confirmation,
            :presence => {:message => "> 请输入密码验证"},
            on: :create
  validates :email,
            :uniqueness => {:message => ">电子邮箱已被注册"},
            on: :create

  before_save { self.email = email.downcase }
  #validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, length: { maximum: 255 },
            #format: { with: VALID_EMAIL_REGEX },
            #uniqueness: { case_sensitive: false }
  has_secure_password


end