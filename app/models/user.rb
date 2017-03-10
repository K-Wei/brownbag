class User < ApplicationRecord
  mount_uploader :profile_picture, ProfilePictureUploader

  before_save :capitalize_user_details

  def capitalize_user_details
    self.first_name = first_name.camelcase
    self.last_name = last_name.camelcase
    self.title = title.camelcase
    self.company = company.camelcase
  end

  # Direct associations

  has_many   :reservations,
             :dependent => :destroy

  has_many   :comments,
             :dependent => :destroy

  has_many   :events,
             :dependent => :destroy

  # Indirect associations

  has_many   :attended_events,
             :through => :reservations,
             :source => :event

  has_many   :commented_events,
             :through => :comments,
             :source => :event

  # Validations
  validates :first_name, :presence => true, length: { minimum: 2, maximum: 30}
  validates :last_name, :presence => true, length: { minimum: 2, maximum: 30}
  validates :linkedin_url, format: { with: /https?:\/\/linkedin.com\/\in\/\w*/ }
  validates :title, :presence => true
  validates :company, :presence => true
  validates :summary, :presence => true
  validates :interests, :presence => true



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
