<my-nav>
  <div class="header">
    <div class="brand">
      <img src="images/fire.png" height="50px" width="50px" />
    </div>
      <h1 class="brand-title">{ title }</h1>
    <div class="user-details">
      <span class="welcome">{ welcomeMsg }</span>
      <span class="button logout" onclick={ logout } if={ welcomeMsg }>Log Out</span>
    </div>
  </div>

  <script>
    this.title = 'Fireside Chat';
    this.welcomeMsg = '';
    var self = this;

    // Update header based on user
    firebase.auth().onAuthStateChanged(function(user) {
    console.log(user);
      if (user) {
        self.welcomeMsg = "Welcome, " + user.email;
      } else {
        self.welcomeMsg = '';
      }
    self.update();
    });

    // logout currently logged in user
    logout(e) {
      firebase.auth().signOut().then(function() {
        console.log("User Signed Out");
        self.update();
      });
    }
  </script>
</my-nav>
