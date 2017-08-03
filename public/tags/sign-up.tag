<sign-up>
  <form onsubmit="{ signup }">
    <div>
      <label for="username">Username</label>
      <input type="email" ref="username" name="username" placeholder="username"/>
      <span class="error">{ username_error }</span>
      <br>
      <label for="password1">Password</label>
      <input onkeyup={ checkpwd } type="password" ref="password1" name="password1" placeholder="password">
      <span class="error">{ pwd1error }</span>
      <br>
      <label for="password2">Enter Password Again</label>
      <input onkeyup={ checkpwd } type="password" ref="password2" name="password2" placeholder="repeat password">
      <span class="error">{ pwd2error }</span>
    </div>
    <button disabled={ disable_submit } type="submit">Create User</button>
  </form>

  <script>
    this.disable_submit = true;

    /* Create user with username and password */
    signup(e) {
      var self = this;
      e.preventDefault();
      var refs = this.refs;
      
      firebase.auth().
      createUserWithEmailAndPassword(refs.username.value, refs.password1.value)
      .then(function() {
        console.log('Successfully created user');
        refs.username.value = '';
        refs.password1.value = '';
        refs.password2.value = '';
          })
      .catch(function(error) {
        // TODO: Check error codes so we can send proper message to proper span
        console.log(error.message);
        self.pwd1error = error.message;
        refs.username.value = '';
        refs.password1.value = '';
        refs.password2.value = '';
        self.update();
          });
    }

    /* Disable submit if passwords don't match */
    checkpwd(e) {
      var pwd1 = this.refs.password1.value;
      var pwd2 = this.refs.password2.value;

      // TODO: Revisit this to see if we can scale it down
      if (pwd2) {
        if (pwd1 === '' && pwd2 === '') {
          this.pwd2error = '';

        } else if (pwd1 != pwd2) {
          this.pwd2error = 'Passwords do not match!';
          this.disable_submit = true;

        } else {
          this.pwd2error = '';
          this.disable_submit = false;
        }
      } else {
        this.pwd2error = '';
      }
    }

    </script>

</sign-up>
