class ProfileForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :age, :integer
  attribute :address, :string

  validates :name, presence: true
  validates :age, presence: true
end
