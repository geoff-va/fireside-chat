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
    // because it's a nested tag, get opts from parent
    var obs = this.parent.opts.interface.obs;

    /* ---------- View Logic ----------- */
    function scrollToBottom(elId) {
      var msgwin = document.getElementById(elId);
      if (msgwin !== null) {
        msgwin.scrollTop = msgwin.scrollHeight;
      }
    }

    // TODO: See if we really need this one
    this.on('mount', function() {
      scrollToBottom("msgwindow");
    });

    /* Round back button */
    back(e) {
      window.location = "#/rooms";
    }

    /* -------- Interface Logic ------------ */
    /* Load the Room Name */
    obs.one('roomname', (name) => {
      self.roomname = name;
      self.update();
    });

    /* Load messages as they come in and scroll to bottom of window */
    obs.on('newMessage', (message) => {
      self.messages.push(message);
      self.update();
      scrollToBottom("msgwindow");
    });
  
  </script>

</room-messages>
