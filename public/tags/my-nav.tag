<my-nav>
  <div class="header">
    <span class="">{ title }</span>
    <span>{ useremail }</span>
    <span onclick={ logout } if={ useremail }>LogOut</span>
  </div>

  <script>
    this.title = 'Fireside Chat';
    this.useremail = '';
    var self = this;

    firebase.auth().onAuthStateChanged(function(user) {
      if (user) {
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
