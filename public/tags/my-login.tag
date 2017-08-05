<my-login>
  <div class="centered-block">
    <form onsubmit="{ login }">
      <div class="input-group">
        <label for="username">User Email</label><br>
        <input class="center" size="25" type="email" ref="username" name="username" placeholder="john@doe.com"/>
      </div>
      <div class="input-group">
        <label for="password">Password</label><br>
        <input class="center" size="25" type="password" ref="password" name="password">
        <div class="error center">{ error }</div>
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
    /* login user with username and password */
    login(e) {
      self = this;  // keep this context
      e.preventDefault();
      var refs = this.refs;
      
      firebase.auth().
      signInWithEmailAndPassword(refs.username.value, refs.password.value)
      .then(function() {
        console.log("Successfully signed in");
        refs.username.value = '';
        refs.password.value = '';
          })
      .catch(function(error) {
        console.log(error.message);
        self.error = error.message;
        refs.username.value = '';
        refs.password.value = '';
        self.update();
      });
    }

  </script>

</my-login>
