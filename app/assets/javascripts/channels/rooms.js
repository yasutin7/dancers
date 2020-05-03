var room_id = $('#messages').data('room_id')
var channel = 'RoomChannel'
document.addEventListener('DOMContentLoaded', function() {
App.room = App.cable.subscriptions.create({ channel: channel, room: room_id }, {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    const messages = document.getElementById('messages');
    messages.innerHTML += message;
    
    // Called when there's incoming data on the websocket for this channel
    // }
  },

  speak: function(message) {
    return this.perform('speak', {message: message});  //messageというパラメータを渡しています。
  }
});

});

document.addEventListener('DOMContentLoaded', function(){
  const input = document.getElementById('chat-input')
  const button = document.getElementById('button')
  button.addEventListener('click', function(){
    const content = input.value
    App.room.speak(data)
    input.value = ''
  });
});

