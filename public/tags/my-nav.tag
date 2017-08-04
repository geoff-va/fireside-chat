<my-nav>
  <div>
    <span>Real Time Chat</span>
    <span>{ useremail }</span>
    <span onclick={ logout } if={ useremail }>LogOut</span>
    <hr>
  </div>

  <script>
    var self = this;
    
    opts.auth.on('signin', function() {
      var user = firebase.auth().currentUser;
      console.log(user.email);
      self.useremail = user.email ? user.email : '';
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
