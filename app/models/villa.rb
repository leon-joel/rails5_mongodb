class Villa
  include Mongoid::Document

  include Mongoid::Timestamps
  field :no, type: Integer
  field :name, type: String
  field :comment, type: String
  embeds_many :attacks, class_name: "Attack", cascade_callbacks: true

  belongs_to :battle, :inverse_of => :villas

  validates :no,
            presence: { message: 'は必須です。' },
            numericality: { allow_blank: true, only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 50 }


  # last_updated 以降に変更された？
  def updated_after?(last_updated)
    return true if last_updated <= updated_at
    attacks.any? { |attack| last_updated <= attack.updated_at }
  end
end
