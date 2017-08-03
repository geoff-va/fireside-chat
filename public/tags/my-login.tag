<my-login>
  <form onsubmit="{ login }">
    <div>
      <label for="username">Username</label>
      <input type="email" ref="username" name="username" placeholder="username"/>
      <br>
      <label for="password">Password</label>
      <input type="password" ref="password" name="password" placeholder="password">
      <br>
      <span class="error">{ error }</span>
    </div>
    <button type="submit">Login</button>
  </form>

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
