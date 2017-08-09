<room-messages>
  <h1><span onclick={ back } class="round-btn button"><</span>{ roomname }</h1>
  <div ref="msgwindow" id="msgwindow" class="messages-window" onscroll={ loadMore }>
    <span ref="loading" class="loading">{ loadingMsg }</span>
    <table class="message-table">
      <tr each={ messages }>
        <td>
          <div>
            <div class="message-user">{ displayname } - { timestamp }</div>
            <div class="message">{ message }</div>
          </div>
        </td>
      </tr>
    </table>
  </div>


  <script>
    this.messages = [];
    this.roomname = '';
    this.loadingMsg = "Loading Messages...";

    var self = this;
    var lastKey = null;
    var numFetched = 0;
    var numToFetch = 10;
    var fetchWaitTime = 1000;  //ms between fetching older messages
    var waitToFetch = false;
    // because it's a nested tag, get opts from parent
    var obs = this.parent.opts.interface.obs;

    /* --------- Local Functions --------- */
    function scrollToBottom(elId) {
      var msgwin = document.getElementById(elId);
      if (msgwin !== null) {
        msgwin.scrollTop = msgwin.scrollHeight;
      }
    }

    /* Fetches additional data as user hits top of scroll bar 
      - Sets timeout preventing additional fetching, so we don't try
        and fetch too much too quickly */
    loadMore(e) {
      if (e.target.scrollTop === 0) {
        if (!waitToFetch) {
          self.refs.loading.classList.add('show-loading');
          waitToFetch = true;
          // If no new data, indicate to user at the beginning
          if (lastKey === self.messages[0].roomKey) {
            self.loadingMsg = "At The Beginning!";
          } else {
            lastKey = self.messages[0].roomKey;
          }
          obs.trigger("requestMore", {quantity: numToFetch, end: lastKey});
          setTimeout(function() {
            waitToFetch=false;
            self.refs.loading.classList.remove('show-loading');
          }, fetchWaitTime);
        }
      }
    }

    // Scrolls to bottom after loading data
    this.on('mount', function() {
      scrollToBottom("msgwindow");
    });

    /* Round back button */
    back(e) {
      window.location = "#/rooms";
    }

    /* ----------- Interface ------------- */
    /* Load the Room Name */
    obs.one('roomname', function(name) {
      self.roomname = name;
      self.update();
    });

    /* Load new messages as they come in and scroll to bottom of window */
    obs.on('newMessage', function(message) {
      self.messages.push(message);
      self.update();
      scrollToBottom("msgwindow");
    });

    /* Loads older messages into the chat window */
    obs.on('addOlderMessage', function(message) {
      /* Since data comes in from firebase always in ascending order,
      splice it into the front of the array for each batch that we fetch.
      The last key it sends is inclusive of endpoint, so we ignore it */
      if (lastKey != message.roomKey) {
        self.messages.splice(numFetched, 0, message)
        numFetched++;
        self.update();
      }
      if (numFetched === numToFetch-1) {
        numFetched = 0;
      }
    });

    // Run Observers
    obs.getRoomName();
    obs.getMessages(10);

  </script>

</room-messages>
