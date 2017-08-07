<my-nav>
  <div class="header">
    <div class="brand">
      <img src="images/fire.png" height="50px" width="50px">
    </div>
      <h1 class="brand-title">{ title }</h1>
    <div class="user-details">
      <span>{ username }</span>
      <span class="button" onclick={ logout } if={ username }>Log Out</span>
    </div>
  </div>

  <script>
    this.title = 'Fireside Chat';
    this.welcomeMsg = "Welcome, "
    this.username = '';
    var self = this;

    firebase.auth().onAuthStateChanged(function(user) {
      if (user) {
        self.username = self.welcomeMsg + user.email;
      } else {
        self.username = '';
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
