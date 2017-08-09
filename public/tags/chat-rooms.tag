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
    <h3 class="empty-rooms" if={ !lastRoom }>{ emptyMsg }</h3>
  </div>

  <script>
    self = this;
    self.rooms = {};
    self.lastRoom = '';
    self.emptyMsg = '';
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
    
    /* If no rooms exist, display msg to user to add one */
    this.one('mount', function() {
      // w/o this timeout, it flashes the error msg before objects load
      // A bit hacky, but works (unless server was really slow :\)
      setTimeout(function() {
        self.emptyMsg = 'No Rooms Exist! Click the + to Create One!';
        self.update();
      }, 1500)
    });

    /* ----------- Interface ------------- */
    /* Subscribe to room additions */
    obs.on('addRoom', function(room) {
      self.lastRoom = room;
      self.rooms[room.id] = room.value;
      self.update();
    });

    /* Subscribe to removals of rooms */
    obs.on('deleteRoom', function(room) {
      delete self.rooms[room.id];
      // Redisplay empty list msg if they have all been deleted
      if (Object.keys(self.rooms).length === 0) {
        self.lastRoom = null;
      }
      self.update();
    });

    /* Subscribe to changes in room details */
    obs.on('changeRoom', function(room) {
        self.rooms[room.id] = room.value;
        self.update();
      });

    // Run Observers
    obs.addRoom();
    obs.deleteRoom();
    obs.changeRoom();

  </script>

</chat-rooms>
