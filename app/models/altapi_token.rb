class AltapiToken < ActiveRecord::Base

    validates :token, presence: true, uniqueness: true
    validates :user_id, presence: true

    belongs_to :user
end
