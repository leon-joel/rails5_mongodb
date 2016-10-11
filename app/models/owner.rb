class Owner
  include Mongoid::Document
  field :name
  field :address
  embedded_in :plan, :inverse_of => :tasks
end