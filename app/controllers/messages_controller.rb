class MessagesController < ApplicationController
  before_action :set_group

  def index
    @message = Message.new
    if params[:lastMessageId].present?
      @messages = @group.messages.where("id > ?", params[:lastMessageId]).includes(:user)
    else
      @messages = @group.messages.includes(:user)
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = Message.new(message_params)
    # binding.pry
    # if @message.save
      # respond_to do |format|
      #   format.html {redirect_to group_messages_path(@group)}
      #   format.json
      # end
    # else
    #   # @message.save!
    #   @messages = @group.messages.includes(:user)
    #   flash.now[:alert] = 'メッセージを入力してください。'
    #   render :index
    # end
    @message.save!
    respond_to do |format|
      format.html {redirect_to group_messages_path(@group)}
      format.json
    end
    # トランザクション
    #処理のロジックはcontrollerに書く
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:text, :image).merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
