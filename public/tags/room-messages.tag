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

    var roomId = "-KqZegV50COjE_qkYkGw";
    var ref = firebase.database().ref('messages/' + roomId);
    ref.orderByChild('timestamp')
      .on('child_added', function(snap) {
        self.messages.push(snap.val());
        self.update();
      });
  </script>

</room-messages>
