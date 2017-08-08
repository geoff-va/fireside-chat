<chat-room>
  <room-messages></room-messages>
  <message-bar></message-bar>

  <script>
    /* Adjust Message Window height to accomodate Message Bar height */
    this.one('mount', () => {
      /* Set limits and initial height */
      this.maxHeight = 105 + 30;
      this.msgBar = this.tags['message-bar'];
      this.msgWin = this.tags['room-messages'];
      var height = this.msgBar.refs.message.scrollHeight;
      this.msgWin.refs.msgwindow.style.bottom = height + 30 + "px";
      
      /* Update height based on msg bar height */
      this.msgBar.on('update', () => {
        var msgBarHeight = this.msgBar.refs.message.scrollHeight + 30;
        var newHeight = Math.min(this.maxHeight, msgBarHeight) + "px";
        this.msgWin.refs.msgwindow.style.bottom = newHeight;
      });
    })

  </script>

</chat-room>
