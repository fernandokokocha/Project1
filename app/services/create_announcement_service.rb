class CreateAnnouncementService
  def call(form_object, current_user)
    form_object.validate!
    Announcement.create(title: form_object.title,
                                    content: form_object.content,
                                    user_id: current_user.id,
                                    category_id: form_object.category_id,
                                    done: false,
                                    edited: false)
  rescue form_object.class::ValidationError
    false
  end

  private
    def announcement_params
      params.require(:announcement).permit(:title, :content, :user_id, :category_id, :done, :edited)
    end
end