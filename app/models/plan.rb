class Plan
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :comment, type: String

  embeds_one :owner

  validates :title,
      presence: true

end
