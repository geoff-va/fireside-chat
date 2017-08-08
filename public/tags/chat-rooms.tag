<chat-rooms>
  <div>
    <h1><span onclick={ createRoom } class="round-btn button">+</span>
      Chat Rooms</h1>
    <table class="room-table">
      <thead>
        <tr>
          <th>Name</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr class="room-row" onclick={ route } each={ val, id in rooms } id={ id }>
          <td>{ val.name }</td>
          <td>{ val.description }</td>
        </tr>
      </tbody>
    </table>
  </div>

  <script>
    self = this;
    self.rooms = {};
    var obs = opts.interface.obs;

    /* --------- Local Functions --------- */
    /* Link to create a new room */
    createRoom(e) {
      window.location = "#/rooms/create";
    }

    /* User clicked on a table row, take them to the room */
    route(e) {
      var room = e.target.parentElement.getAttribute('id');
      window.location = "#/room/" + room;
    }

    /* ----------- Interface ------------- */
    /* Subscribe to room additions */
    obs.on('addRoom', (room) => {
      self.rooms[room.id] = room.value;
      self.update();
    });

    /* Subscribe to removals of rooms */
    obs.on('deleteRoom', (room) => {
      delete self.rooms[room.id];
      self.update();
    });

    /* Subscribe to changes in room details */
    obs.on('changeRoom', (room) => {
        self.rooms[room.id] = room.value;
        self.update();
      });

    // Run Observers
    obs.addRoom();
    obs.deleteRoom();
    obs.changeRoom();

  </script>

</chat-rooms>
