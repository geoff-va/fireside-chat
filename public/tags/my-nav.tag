<my-nav>
  <div class="header">
    <div class="brand">
      <img src="images/fire.png" height="50px" width="50px">
    </div>
      <h1 class="brand-title">{ title }</h1>
    <div class="user-details">
      <span>Welcome, { useremail }</span>
      <span class="button" onclick={ logout } if={ useremail }>Log Out</span>
    </div>
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
