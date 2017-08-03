<my-nav>
  <div>
    <span>Real Time Chat</span>
    <span>{ useremail }</span>
    <span onclick={ logout } if={ useremail }>LogOut</span>
    <hr>
  </div>

  <script>
  var user = firebase.auth().currentUser;
  this.useremail = user ? user.email : '';

    logout(e) {
      firebase.auth().signOut().then(function() {
        console.log("User Signed Out");
      });
    }
  </script>
</my-nav>
