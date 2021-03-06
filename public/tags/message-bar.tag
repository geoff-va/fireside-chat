<message-bar>
    <form onsubmit={ send_message }>
      <div class="message-bar">
        <span class="button" onclick={ send_message }>Send</span>
        <div class="msg-text-box">
          <textarea onkeydown={ handleDown } oninput={ adjustHeight } rows="1" ref="message" placeholder="Message" name="msgbox"/>
        </div>
      </div>
    </form>


  <script>
    this.maxHeight = "105";
    this.msg = this.refs.message;
    var self = this;
    var obs = this.parent.opts.interface.obs;

    /* --------- Local Functions --------- */
    /* Reset bar height and optionally clear input */
    function adjustMsgBarHeight(clearInput) {
      if (clearInput) {
        self.refs.message.value = '';
      }
      self.refs.message.style.height = '';
      self.refs.message.style.height = Math.min(self.maxHeight, self.refs.message.scrollHeight) + "px";
    }

    /* Set initial height of textarea */
    this.one('mount', function() {
        this.refs.message.style.height = '';
        this.refs.message.style.height = this.refs.message.scrollHeight + "px";
    });

    /* Adjust input height as user enters new lines so it grows/shrinks */
    adjustHeight(e) { 
      adjustMsgBarHeight(false);
    }

    /* Handle Shift+Enter for new lines, Enter for sending message */
    handleDown(e) {
      console.log(e);
      if (e.keyCode === 13 && e.shiftKey) {
        // Let it create a new line itself;

      } else if (e.keyCode === 13) {
        e.preventDefault();
        self.send_message();
        adjustMsgBarHeight(true);
      }
    }

    /* ----------- Interface ------------- */
    /* Submit message content */
    send_message(e) {
      if (e) {
        e.preventDefault();
      }

      // Do nothing if empty 
      if (self.refs.message.value.trim() === '') {
        return;
      }

      // message content
      var content = {
        message: this.refs.message.value,
        timestamp: Date.now(),
      };
      obs.trigger("send", content);
      adjustMsgBarHeight(true);  // reset input bar height
    }
    </script>
</message-bar>
