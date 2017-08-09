<add-room>
  <h1>
    <span onclick={ back } class="round-btn button"><</span>
    Create New Room
  </h1>
  <div class="inline">
    <form onsubmit={ create_room }>
      <div class"inline">
        <label class="aligned-label" for="roomname">Room Name</label>
        <input ref="roomname" type="text" size="30" placeholder="Outdoor Activities" required />
      </div>
      <div class="inline">
        <label class="aligned-label" for="description">Room Description</label>
        <input ref="description" type="text" size="50" placeholder="For people who love the outdoors" required />
      </div>
      <div>
        <span class="error">{ error }</span><br>
        <button class="button" type="submit">Create Room</button>
      </div>
    </form>
  </div>
  <div>
  </div>


  <script>
    var obs = opts.interface.obs;
    
    /* --------- Local Functions --------- */
    /* Round back button */
    back(e) {
      window.location = "#/rooms";
    }

    /* ----------- Interface ------------- */
    /* Create new room */
    create_room(e) {
      e.preventDefault();
      var content = {
        roomname: this.refs.roomname.value,
        description: this.refs.description.value
      };
      obs.trigger('addRoom', content);
    }

    /* Update for error conditions */
    obs.on('error', function(error) {
      this.error = error;
      this.update();
    });

    /* No Error, go to nextView */
    obs.on('success', function(params) {
      window.location = params.nextView;
    });


  </script>
</add-room>
