<chat-rooms>
  <div>
    <table class="room-table">
      <thead>
        <tr>
          <th>Name</th>
          <th>Description</th>
          <th># Occupants</th>
        </tr>
      </thead>
      <tbody>
        <tr class="room-row" onclick={ route } each={ val, id in rooms } id={ id }>
          <td>{ val.name }</td>
          <td>{ val.description }</td>
          <td>{ val.members }</td>
        </tr>
      </tbody>
    </table>
    <a href="#/rooms/create">Create Room</a>
  </div>

  <script>
    self = this;
    self.rooms = {};
    var obs = opts.interface.obs;

    /* ---------- View Logic --------- */
    route(e) {
      var room = e.target.parentElement.getAttribute('id');
      window.location = "#/room/" + room;
    }

    /* -------- Interface Logic --------- */
    /* Subscribe to room additions */
    obs.on('addRoom', (room) => {
      console.log("adding room from .tag: " + room.value.name)
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
