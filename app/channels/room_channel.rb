class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data) # room.jsのspeakから渡されたパラメータをdataで取得
    message =  Message.create!(content: data['message'], user_id: current_user.id, room_id: params['room'])
    template = ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    # rooms.jsのreceivedにブロードキャストする
    ActionCable.server.broadcast "room_channel_#{message.room_id}", template
  end
end
