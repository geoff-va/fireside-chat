<my-nav>
  <div>
    <span>Real Time Chat</span>
    <span>{ useremail }</span>
    <span onclick={ logout } if={ useremail }>LogOut</span>
    <hr>
  </div>

  <script>
    var self = this;
    this.useremail = '';

    firebase.auth().onAuthStateChanged(function(user) {
      if (user) {
        console.log(user);
          self.useremail = user.email;
      } else {
          self.useremail = '';
      }
    self.update();

    });

    logout(e) {
      firebase.auth().signOut().then(function() {
        console.log("User Signed Out");
        self.update();
      });
    }
  </script>
</my-nav>
