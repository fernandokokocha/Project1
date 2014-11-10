class Reply < ActiveRecord::Base
  belongs_to :announcement
  belongs_to :user
end
