class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
  validates :email, presence: true, uniqueness: true
  validates :callsign, presence: true, uniqueness: true, length: {minimum: 3}, format: /^[A-z0-9]{1,3}[0-9][A-z]+$/
  def callsign
    self.read_attribute(:callsign).upcase
  end

  def callsign= callsign
    super callsign.upcase
  end
end
