<my-login>
  <div class="centered-block">
    <form onsubmit="{ login }">
      <div class="input-group">
        <label for="username">User Email</label><br>
        <input class="center" size="25" type="email" ref="username" name="username" placeholder="john@doe.com"/>
        <div class="error center">{ error }</div>
      </div>
      <div class="input-group">
        <label for="password">Password</label><br>
        <input class="center" size="25" type="password" ref="password" name="password">
      </div>
      <div class="center">
        <button class="button" type="submit">Login</button>
      </div>
    </form>
    <div class="subtle-text center">
      <span>Not a current user?&nbsp;</span><br>
      <a href="/#/signup">Sign Up</a>
    </div>
  </div>

  <script>
    var self = this;

    /* Translate errors to something more user friendly */
    function setError(error) {
      if (error.code === "auth/user-not-found") {
        self.error = "User with email " + self.refs.username.value + 
          " cannot be found.";
      } else if (error.code === "auth/wrong-password") {
        self.error = "Incorrect username or password.";
      } else {
        self.error = error.message;
      }
      self.update();
    }
    
    /* Reset the input fields */
    function resetFields() {
      self.refs.username.value = '';
      self.refs.password.value = '';
      self.update();
    }

    /* login user with username and password */
    login(e) {
      self = this;  // keep this context
      e.preventDefault();
      var refs = this.refs;
      
      firebase.auth().
      signInWithEmailAndPassword(refs.username.value, refs.password.value)
      .then(function() {
        console.log("Successfully signed in");
        self.error ='';
        resetFields();
          })
      .catch(function(error) {
        console.log(error.code);
        console.log(error.message);
        setError(error);
        resetFields();
      });
    }

  </script>

</my-login>
