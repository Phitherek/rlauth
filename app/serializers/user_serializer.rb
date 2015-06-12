class UserSerializer < ActiveModel::Serializer
  attributes :id, :callsign, :email
end
