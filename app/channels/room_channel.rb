class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'room_channel_#{params[:room_id]}'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data) #room.jsのspeakから渡されたパラメータをdataで取得
    binding.pry
    message =  Message.create!(content: data['message'], user_id: current_user.id, room_id: params['room_id'])
    template = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
     # rooms.jsのreceivedにブロードキャストする
    ActionCable.server.broadcast 'room_channel_#{message.room_id}',message: template, room_id: params['room_id']
  end
 
end
