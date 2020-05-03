class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def show
    if @room = Room.find(params[:id]).nil?
      @room = Room.create(id: params[:id], user_id: current_user.id)
    else
      @room = Room.find(params[:id])
    end
    @messages = @room.messages
  end
  
  def create
    @room = Room.new
    @room.save
    redirect_to rooms_path
  end

end
