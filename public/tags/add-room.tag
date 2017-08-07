<add-room>
  <h3>Create New Room</h3>
  <div class="inline">
    <form onsubmit={ create_room }>
      <div class"inline">
        <label class="aligned-label" for="roomname">Room Name</label>
        <input ref="roomname" type="text" size="30" placeholder="Outdoor Activities" />
      </div>
      <div class="inline">
        <label class="aligned-label" for="description">Room Description</label>
        <input ref="description" type="text" size="50" placeholder="For people who love the outdoors" />
      </div>
      <div>
        <span class="error">{ error }</span><br>
        <button class="button" type="submit">Create Room</button>
      </div>
    </form>
  </div>
  <div>
    <a class="subtle-text" onclick={ back } href='#/'>Back to Rooms</a>
  </div>


  <script>
    var self = this;
    back(e) {
      history.back();
    }

    create_room(e) {
      e.preventDefault();
      var self = this;
      console.log("Creating room: " + this.refs.roomname.value);
      var ref = firebase.database().ref('rooms');
      ref.orderByChild('name').equalTo(this.refs.roomname.value)
        .once('value', function(snap) {
          console.log("Room found: " + snap.val());
          if (snap.val() === null) {
            var content = {
              name: self.refs.roomname.value,
              description: self.refs.description.value
            };

            ref.push(content);
            self.error = '';
            self.refs.roomname.value = '';
            self.refs.description.value = '';
            window.location = "#/rooms";

            } else {
              self.error = "Sorry, but " + self.refs.roomname.value + " already exists!";
              self.update();
            }
        });

    }

  </script>
</add-room>
