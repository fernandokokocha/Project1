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
		@reply = Reply.new
    @announcement = Announcement.new
		@categories = Category.all
    respond_with(@announcement)
  end

  def edit
		authenticate_user!
		@categories = Category.all
  end

  def create
		authenticate_user!
		@categories = Category.all
    @announcement = Announcement.new(announcement_params)
		@announcement.user = current_user
    @announcement.done = false
    @announcement.edited = false
    @announcement.save
    respond_with(@announcement)
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
      params.require(:announcement).permit(:title, :content, :user_id, :category_id)
    end
end
