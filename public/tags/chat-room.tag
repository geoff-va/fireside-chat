<chat-room>
  <room-messages roomid={ opts[1] }></room-messages>
  <message-bar roomid={ opts[1] }></message-bar>
  <a href="/#/rooms">Back to rooms</a>

  <script>
    console.log('chat-room: ' + opts[1]);
  </script>

</chat-room>
