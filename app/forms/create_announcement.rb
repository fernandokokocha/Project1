class CreateAnnouncement
  ValidationError = Class.new(StandardError)

  include Virtus.model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :title, String
  attribute :content, String
  attribute :category_id, Integer
  attribute :done, Boolean
  attribute :edited, Boolean

  validates :title, presence: true
  validates :content, presence: true
  validates :category_id, presence: true

  def persisted?
    false
  end

  def validate!
    raise ValidationError, errors unless valid?
  end
end