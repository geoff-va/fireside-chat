<message-bar>
  <div>
    <form onsubmit={ send_message }>
      <input ref="message" size="50" type="text" placeholder="Message"/>
      <button type="submit">Send</button>
    </form>
  </div>



  <script>
    this.roomId = "-KqZegV50COjE_qkYkGw";

    send_message(e) {
      e.preventDefault();
      var ref = firebase.database().ref('messages/' + this.roomId);
      var content = {
        message: this.refs.message.value,
        userid: firebase.auth().currentUser.uid,
        timestamp: Date.now()
      }
      ref.push(content);
    }
    </script>
</message-bar>
