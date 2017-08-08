<message-bar>
    <form onsubmit={ send_message }>
      <div class="message-bar">
        <span class="button" onclick={ send_message }>Send</span>
        <div class="msg-text-box">
          <textarea rows="1" ref="message" placeholder="Message"/>
        </div>
      </div>
    </form>


  <script>
    var obs = this.parent.opts.interface.obs;
  
    /* -------- Interface Logic ------------ */
    /* Submit message content */
    send_message(e) {
      e.preventDefault();
      var content = {
        message: this.refs.message.value,
        timestamp: Date.now(),
      };
      obs.trigger("send", content);
      this.refs.message.value = '';
    }
    </script>
</message-bar>
