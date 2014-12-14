class CreateAnnouncement
  ValidationError = Class.new(StandardError)

  include Virtus.model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :title, String
  attribute :content, String
  attribute :user_id, Integer
  attribute :category_id, Integer
  attribute :done, Boolean
  attribute :edited, Boolean

  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
  validates :category_id, presence: true

  def persisted?
    false
  end

  def validate!
    raise ValidationError, errors unless valid?
  end

  def save
    if valid?
      persist!
    else
      false
    end
  end

  private
    def persist!
      @announcement = Announcement.create!(title: title, content: content, user_id: user_id, category_id: category_id, done: done, edited: edited)
    end
end