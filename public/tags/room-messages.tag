<room-messages>
  <h1>
    <span onclick={ back } class="round-btn button"><</span>
    Chatting in: { roomname }
  </h1>
  <div id="msgwindow" class="messages-window">
    <table class="message-table">
      <tr each={ messages }>
        <td>
          <div>
            <div class="message-user">{ displayname }</div>
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
        var msgwin = document.getElementById('msgwindow');
        if (msgwin !== null) {
          msgwin.scrollTop = msgwin.scrollHeight;
        }
      });

    // Necessary when coming back to the page
    this.on('mount', function() {
        var msgwin = document.getElementById('msgwindow');
        if (msgwin !== null) {
          console.log('mount');
          msgwin.scrollTop = msgwin.scrollHeight;
        }
      })

    back(e) {
      window.location = "#/rooms";
    }
  </script>

</room-messages>
