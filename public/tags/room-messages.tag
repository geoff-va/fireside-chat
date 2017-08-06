<room-messages>
  <h1>
    <span tooltip="Back to Rooms" onclick={ back } class="round-btn button"><</span>
    Chatting in: { roomname }
  </h1>
  <div id="msgwindow" class="messages-window">
    <table class="message-table">
      <tr each={ messages }>
        <td>
          <div>
            <div class="message-user">{ useremail }</div>
            <div class="message">{ message }</div>
          </div>
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
        // TODO: This is probably occuring for each message and should happen
        // once after all messages are loaded
        // window.scrollTo(0, document.body.scrollHeight);
      });

    back(e) {
      window.location = "#/rooms";
    }
  </script>

</room-messages>
