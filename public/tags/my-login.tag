<my-login>
  <div class="centered-block">
    <form onsubmit="{ login }">
      <div class="input-group">
        <label for="username">User Email</label><br>
        <input class="center" size="25" type="email" ref="username" name="username" placeholder="john@doe.com" required/>
        <div class="error center">{ error }</div>
      </div>
      <div class="input-group">
        <label for="password">Password</label><br>
        <input class="center" size="25" type="password" ref="password" name="password" required>
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
    var auth = opts.interface.auth;
    var self = this;
    var refs = this.refs;
    /* ------ Local Functions -------- */
    /* Reset the input fields */
    function resetFields() {
      self.refs.username.value = '';
      self.refs.password.value = '';
      self.update();
    }

    /* ------------ Interface ---------- */
    /* login user with username and password */
    login(e) {
      e.preventDefault();
      var payload = {
        username: refs.username.value,
        password: refs.password.value
      };
      auth.trigger('login', payload);
    }

    /* Handle any errors that come back from login */
    auth.on('error', function(data) {
      self.error = data;
      self.update();
    });

    auth.on('success', (params) => {
      window.location = params.nextView;
    });

  </script>

</my-login>
