<message-bar>
    <form onsubmit={ send_message }>
      <div class="message-bar">
        <span class="button" onclick={ send_message }>Send</span>
        <div class="msg-text-box">
          <textarea onkeydown={ handleDown } onkeyup={ handleUp } rows="1" ref="message" placeholder="Message"/>
        </div>
      </div>
    </form>


  <script>
    var self = this;
    var obs = this.parent.opts.interface.obs;
    
    /*----------- View Logic ---------- */
    /* Send message if shift not held down */
    handleUp(e) {
      if (e.key === 'Enter' && !e.shiftKey) {
        self.send_message();
      }
    }

    /* Add newline if Shift+Enter */
    handleDown(e) {
      if (e.key === 'Enter' && e.shiftKey) {
        // Let it create a new line itself;
      } else if (e.key === 'Enter') {
        e.preventDefault();
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
      this.refs.message.value = '';
    }
    </script>
</message-bar>
