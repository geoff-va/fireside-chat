<chat-rooms>
  <div>
    <table>
      <tr>
        <th>Name</th>
        <th>Description</th>
        <th># Occupants</th>
      </tr>
      <tr each={ val, id in rooms }>
        <td>{ val.name }</td>
        <td>{ val.description }</td>
        <td>{ val.members }</td>
      </tr>
    </table>
  </div>

  <script>
    self = this;
    self.rooms = {};

    var ref = firebase.database().ref('rooms');
    ref.orderByChild('name')
      .on('child_added', function(snap) {
        self.rooms[snap.key] = snap.val();
        self.update();
      });

  </script>

</chat-rooms>
