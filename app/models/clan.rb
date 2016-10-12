class Clan
  include Mongoid::Document

  include Mongoid::Timestamps
  field :code, type: String
  field :name, type: String

  has_many :battles, dependent: :destroy
end
