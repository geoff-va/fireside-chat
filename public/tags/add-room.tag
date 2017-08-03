<add-room>
  <h3>Add Room</h3>
  <div>
    <form onsubmit={ create_room }>
      <label for="roomname">Room Name</label>
      <input ref="roomname" type="text" size="30" placeholder="Room Name" />
      <br>
      <label for="description">Room Description</label>
      <input ref="description" type="text" size="50" placeholder="Room Description" />
      <button type="submit">Create Room</button>
      <br>
      <span class="error">{ error }</span>
    </form>
  </div>


  <script>
    create_room(e) {
      e.preventDefault();
      var self = this;
      var ref = firebase.database().ref('rooms');

      ref.orderByChild('name').equalTo(this.refs.roomname.value)
        .once('value', function(snap) {
          console.log(snap.val());
          if (snap.val() === null) {
            var content = {
              name: self.refs.roomname.value,
              description: self.refs.description.value
            };

            ref.push(content);
            self.error = '';
            self.refs.roomname.value = '';
            self.refs.description.value = '';

            } else {
              this.error = "Sorry, but " + self.refs.roomname.value + " already exists!";
            }
        });

    }

  </script>
</add-room>
