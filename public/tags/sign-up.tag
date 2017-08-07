<sign-up>
  <div class="centered-block">
    <form onsubmit="{ signup }">
      <div class="input-group">
        <label for="username">Email</label><br>
        <input class="center "size="25" type="email" ref="username" name="username" placeholder="john@doe.com" required/>
        <div class="error center">{ username_error }</div>
      </div>
      <div class="input-group">
        <label for="displayname">Display Name</label><br>
        <input class="center "size="25" type="text" ref="displayname" name="displayname" placeholder="Johnny B. Good" required/>
        <div class="error center">{ displayname_error }</div>
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

    /* Clear input fields */
    function resetFields() {
      var refs = self.refs;
      refs.username.value = '';
      refs.displayname.value = '';
      refs.password1.value = '';
      refs.password2.value = '';
      self.update();
    }

    /* Clear error fields */
    function resetErrors() {
      self.username_errpr = '';
      self.pwd1_error = '';
      self.pwd2_error = '';
      self.displayname_error = '';
    }
  
    /* Set appropriate error field based on error code */
    function setError(error) {
      resetErrors();
      if (error.code === 'auth/email-already-in-use' || error.code === "auth/invalid-email") {
        self.username_error = error.message;
      } else if (error.code === 'auth/weak-password') {
        self.pwd1_error = error.message;
      }
    }

    /* Create user with username and password */
    signup(e) {
      var self = this;
      e.preventDefault();
      var refs = this.refs;
      
      firebase.auth().
      createUserWithEmailAndPassword(refs.username.value, refs.password1.value)
      .then(function(user) {
          user.updateProfile({
            displayName: refs.displayname.value,
            photoURL: ''
              });
        console.log('Successfully created user');
        resetFields();
          })
      .catch(function(error) {
        // TODO: Check error codes so we can send proper message to proper span
        console.log("CODE: " + error.code);
        console.log(error.message);
        setError(error);
        self.update();
        // resetFields();
          });
    }

    /* Disable submit if passwords don't match */
    checkpwd(e) {
      var pwd1 = this.refs.password1.value;
      var pwd2 = this.refs.password2.value;

      // TODO: Revisit this to see if we can scale it down
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
    

    </script>

</sign-up>
