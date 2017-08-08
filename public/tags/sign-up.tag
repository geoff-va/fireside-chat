<sign-up>
  <div class="centered-block">
    <form onsubmit="{ signup }">
      <div class="input-group">
        <label for="useremail">Email</label><br>
        <input class="center "size="25" type="email" ref="useremail" name="useremail" placeholder="john@doe.com" required/>
        <div class="error center">{ useremail_error }</div>
      </div>
      <div class="input-group">
        <label for="displayname">Display Name</label><br>
        <input class="center "size="25" type="text" ref="displayname" name="displayname" placeholder="Johnny B. Good" required/>
      </div>
      <div class="input-group">
        <label for="password1">Password</label><br>
        <input class="center" size="25" onkeyup={ checkpwd } type="password" ref="password1" name="password1" required>
        <div class="error center">{ pwd1_error }</div>
      </div>
      <div class="input-group">
        <label for="password2">Re-enter Password</label><br>
        <input class="center" size="25" onkeyup={ checkpwd } type="password" ref="password2" name="password2" required>
        <div class="error center">{ pwd2_error }</div>
      </div>
      <div class="center">
        <button class="button" disabled={ disable_submit } type="submit">Create User</button>
    </form>
  </div>
  <div class="subtle-text center">
    <a href="/#/login">Back to Login</a>
  </div>

  <script>
    this.disable_submit = true;
    var self = this;
    var obs = opts.interface.obs;
  
    /* -------- View Logic ----------- */
    /* Clear input fields */
    function resetFields(names, passwords) {
      var refs = self.refs;
      if (names) {
        refs.useremail.value = '';
        refs.displayname.value = '';
        refs.password1.value = '';
        refs.password2.value = '';
        refs.useremail.select();
      } else if (passwords) {
        refs.password1.value = '';
        refs.password2.value = '';
        refs.password1.select();
      }
    }

    /* Disable submit if passwords don't match */
    checkpwd(e) {
      var pwd1 = this.refs.password1.value;
      var pwd2 = this.refs.password2.value;

      if (pwd2) {
        if (pwd1 === '' && pwd2 === '') {
          this.pwd2_error = '';

        } else if (pwd1 != pwd2) {
          this.pwd2_error = 'Passwords do not match!';
          this.disable_submit = true;

        } else {
          this.pwd2_error = '';
          this.disable_submit = false;
        }
      } else {
        this.pwd2_error = '';
      }
    }

    /* ------------ Interface Logic ------------ */
    /* Create user with username and password */
    signup(e) {
      e.preventDefault();
      var refs = self.refs;
      var payload = {
        useremail: refs.useremail.value,
        displayname: refs.displayname.value,
        password: refs.password1.value
      }
      obs.trigger('signup', payload);
    }

    /* Display errors returned by signup */
    obs.on('error', (error) => {
      resetFields(error.useremail_error, error.pwd1_error);
      self.useremail_error = error.useremail_error;
      self.pwd1_error = error.pwd1_error;
      self.update();
    });

    /* Go to next view on success */
    obs.on('success', (params) => {
      window.location = params.nextView;
    });

    </script>

</sign-up>
