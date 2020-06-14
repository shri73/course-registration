class User < ApplicationRecord
  #authenticate password
  has_secure_password

  #basic password validation
  validates_length_of       :password, maximum: 72, minimum: 8, allow_nil: false, allow_blank: false
  validates_confirmation_of :password, allow_nil: false, allow_blank: false

  #ensure username and email are unique and present
  validates_presence_of     :email
  validates_presence_of     :username
  validates_uniqueness_of   :email
  validates_uniqueness_of   :username

  has_many :enrollments
  has_many :courses, through: :enrollments

  # This method gives us a simple call to check if a user has permission to modify.
  def can_modify_user?(user_id)
    role == 'admin' || id.to_s == user_id.to_s
  end

  # This method tells us if the user is an admin or not.
  def is_admin?
    role == 'admin'
  end
end
