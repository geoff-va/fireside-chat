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

    /*----------- View Logic ---------- */
    /* Reset bar height and optionally clear input */
    function adjustMsgBarHeight(clearInput) {
      if (clearInput) {
        self.refs.message.value = '';
      }
      self.refs.message.style.height = '';
      self.refs.message.style.height = Math.min(self.maxHeight, self.refs.message.scrollHeight) + "px";
    }

    /* Set initial height ot textarea */
    this.one('mount', () => {
        this.refs.message.style.height = '';
        this.refs.message.style.height = this.refs.message.scrollHeight + "px";
    });

    /* Adjust bar height on input changes so it grows/shrinks */
    adjustHeight(e) { 
      adjustMsgBarHeight(false);
    }

    /* Handle Shift+Enter for new lines, Enter for sending message */
    handleDown(e) {
      if (e.key === 'Enter' && e.shiftKey) {
        // Let it create a new line itself;

      } else if (e.key === 'Enter') {
        e.preventDefault();
        self.send_message();
        adjustMsgBarHeight(true);
      }
    }

    /* -------- Interface Logic ------------ */
    /* Submit message content */
    send_message(e) {
      if (e) {
        e.preventDefault();
      }

      // Do nothing if empty 
      if (self.refs.message.value.trim() === '') {
        return;
      }

      var content = {
        message: this.refs.message.value,
        timestamp: Date.now(),
      };
      obs.trigger("send", content);
      adjustMsgBarHeight(true);
    }
    </script>
</message-bar>
