class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @announcements = Announcement.all
    respond_with(@announcements)
  end

  def show
		@reply = Reply.new
		@ann_id = @announcement.id

    respond_to do |format|
      format.html
      format.json { render json: @announcement }
    end
  end

  def new
		authenticate_user!
    @announcement = Announcement.new
		@categories = Category.all
  end

  def edit
		authenticate_user!
		@categories = Category.all
  end

  def create
		authenticate_user!
		@categories = Category.all
    @announcement = CreateAnnouncement.new(announcement_params)
    @persisted = create_announcement_service.call(@announcement, current_user)
    respond_to do |format|
      if @persisted
        format.html { redirect_to announcement_path(:id => @persisted), notice: 'Announcement was successfully created.' }
      else
        format.html { redirect_to new_announcement_path }
      end
    end
  end

  def update
		authenticate_user!
		@categories = Category.all
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to announcement_path(:id => @announcement.id), notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authenticate_user!
    @announcement.destroy
    respond_with(@announcement)
  end

  def get_content
    respond_to do |format|
      format.js
    end
  end

  private
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    def announcement_params
      params.require(:announcement).permit(:title, :content, :category_id)
    end

    def create_announcement_service
      @create_announcement_service ||= CreateAnnouncementService.new
    end
end
