class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

  respond_to :html

  def index
    @replies = Reply.all
    respond_with(@replies)
  end

  def show
  end

  def new
    @reply = Reply.new
    respond_with(@reply)
  end

  def edit
  end

  def create
    @reply = Reply.new(reply_params)
		@reply.user_id = current_user.id
    @reply.save
		redirect_to announcement_path(:id => @reply.announcement_id)
  end

  def update
    @reply.update(reply_params)
    respond_with(@reply)
  end

  def destroy
    @reply.destroy
    respond_with(@reply)
  end

  private
    def set_reply
      @reply = Reply.find(params[:id])
    end

    def reply_params
      params.require(:reply).permit(:content, :announcement_id)
    end
end
