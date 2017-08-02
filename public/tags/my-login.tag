<my-login>
  <form onsubmit="{ login }">
    <div>
      <label for="username">Username</label>
      <input type="text" ref="username" name="username" placeholder="username"/>
      <br>
      <label for="password">Password</label>
      <input type="password" ref="password" name="password" placeholder="password">
    </div>
    <div class="error">
      <ul>
        <li each={ error in errors }>
      </ul>
    </div>
    <button type="submit">Login</button>
  </form>

  <script>
    this.errors = [];

    /* login user with username and password */
    login(e) {
      e.preventDefault();
      var refs = this.refs;
      
      firebase.auth().
      signInWithEmailAndPassword(refs.username.value, refs.password.value)
      .then(function() {
        console.log("Successfully signed in");
          })
      .catch(function(error) {
        console.log(error.message);
          });
    }
  </script>

</my-login>
