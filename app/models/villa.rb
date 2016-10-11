class Villa
  include Mongoid::Document

  include Mongoid::Timestamps
  field :no, type: Integer
  field :name, type: String
  field :comment, type: String
  embeds_many :attacks, class_name: "Attack", cascade_callbacks: true

  embedded_in :battle, :inverse_of => :villas

  validates :no,
            presence: { message: 'は必須です。' },
            numericality: { allow_blank: true, only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 50 }

end
