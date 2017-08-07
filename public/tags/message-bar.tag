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

    send_message(e) {
      e.preventDefault();
      var ref = firebase.database().ref('messages/' + opts.roomid);
      var user = firebase.auth().currentUser;
      var content = {
        message: this.refs.message.value,
        displayname: user.displayName,
        timestamp: Date.now(),
        userid: user.uid
      };

      ref.push(content).catch(function(error) {
        console.log(error);
      });
      this.refs.message.value = '';
    }
    </script>
</message-bar>
