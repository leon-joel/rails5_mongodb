class Battle
  include Mongoid::Document

  include Mongoid::Timestamps
  field :code, type: String
  field :opponent_name, type: String
  field :base_count, type: Integer

  embeds_many :villas, class_name: "Villa", cascade_callbacks: true
  # cascade_callbacks: true にしないと、子要素に created_at などのtimestampsがセットされない

  belongs_to :clan

  validates :code, presence: true
  validates :opponent_name, presence: true
  validates :base_count,
            presence: { message: 'は必須です。' },
            numericality: { allow_blank: true, only_integer: true, greater_than_or_equal_to: 10, less_than_or_equal_to: 50 },
            inclusion: { in: [10, 15, 20, 25, 30, 40, 50] }
end
