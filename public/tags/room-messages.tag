<room-messages>
  <h3>Chatting in: { roomname }</h3>
  <div>
    <table>
      <tr each={ messages }>
        <td>{ useremail } - { message }
        </td>
      </tr>
    </table>
  </div>


  <script>
    this.messages = [];
    this.roomname = '';
    var self = this;
  
    // Retrieve room name
    var roomref = firebase.database().ref('rooms/' + opts.roomid);
    roomref.once('value', function(snap) {
      self.roomname = snap.val().name;
    });

    var msgref = firebase.database().ref('messages/' + opts.roomid);
    console.log('room-message: ' + opts.roomid);

    // TODO: Limit to last X messages, add more as user scrolls up in history
    msgref.orderByChild('timestamp')
      .on('child_added', function(snap) {
        self.messages.push(snap.val());
        self.update();
      });
  </script>

</room-messages>
