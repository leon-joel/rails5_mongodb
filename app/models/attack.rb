class Attack
  include Mongoid::Document

  include Mongoid::Timestamps
  field :name, type: String
  field :comment, type: String
  field :result, type: Integer

  embedded_in :villa, :inverse_of => :attacks

  validates :name, presence: true
  validates :result,
            presence: { message: 'は必須です。' },
            numericality: { allow_blank: true, only_integer: true, greater_than_or_equal_to: -1, less_than_or_equal_to: 3 }

end
