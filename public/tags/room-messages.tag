<room-messages>
  <h3>Messages</h3>
  <div>
    <table>
      <tr each={ messages }>
        <td>{ useremail } - { message }
        </td>
      </tr>
    </table>
  </div>


  <script>
    this.messages = [];
    var self = this;

    var ref = firebase.database().ref('messages/' + opts.roomid);
    console.log('room-message: ' + opts.roomid);

    // TODO: Limit to last X messages, add more as user scrolls up in history
    ref.orderByChild('timestamp')
      .on('child_added', function(snap) {
        self.messages.push(snap.val());
        self.update();
      });
  </script>

</room-messages>
