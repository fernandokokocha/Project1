class Admin::RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

  respond_to :html

  def index
    unless current_user && current_user.admin?
      flash[:alert] = "Secured!"
      redirect_to root_path
    end
    @replies = Reply.all
  end

  def show
    unless current_user && current_user.admin?
      flash[:alert] = "Secured!"
      redirect_to root_path
    end
  end

  def new
    @reply = Reply.new
  end

  def edit
  end

  def create
    @reply = Reply.new(reply_params)
		@reply.user = current_user
    respond_to do |format|
      if @reply.save
        format.html { redirect_to announcement_path(:id => @reply.announcement_id), notice: 'Reply was successfully created.' }
        format.json { render :show, status: :created, location: @reply }
      else
        format.html { render :new }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to announcement_path(:id => @reply.announcement_id), notice: 'Reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to admin_replies_url, notice: 'Reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_reply
      @reply = Reply.find(params[:id])
    end

    def reply_params
      params.require(:reply).permit(:content, :announcement_id)
    end
end
