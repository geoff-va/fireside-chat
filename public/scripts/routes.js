;(function(riot, firebase, rtcApp) {
  var routes = rtcApp.routes = rtcApp.routes || (function() {

    /* Login view function */
    var login = function() {
      var auth = riot.observable();

      auth.on('login', (params) => {
        firebase.auth().
        signInWithEmailAndPassword(params.username, params.password)
          .then(() => {
            console.log("Successful Login for: " + params.username);
            auth.trigger('success', {nextView: "#/rooms"});
          })
          .catch((error) => {
            // Interpret error and return to view
            var msg = '';
            if (error.code === "auth/user-not-found") {
              msg = "User with email " + params.username +
                " cannot be found.";
            } else if (error.code === "auth/wrong-password") {
              msg = "Incorrect username or password.";
            } else {
              msg = error.message;
            }
            auth.trigger('error', msg);
        });
      });

      return {auth: auth};
    }

    /* Sign up a new user */
    var signup = function() {
      var obs = riot.observable();

      obs.on('signup', (data) => {
        firebase.auth()
        .createUserWithEmailAndPassword(data.useremail, data.password)
        .then((user) => {
          // Add display name to user profile
          user.updateProfile({
            displayName: data.displayname,
            photoURL: ''
          });

          // Go to next view
          obs.trigger('success', {nextView: "#/rooms"} );
        })
        .catch((error) => {
          var useremail_error = '';
          var pwd1_error = '';

          // Organize errors
          if (error.code === 'auth/email-already-in-use') {
            useremail_error = "The email address '" + data.useremail +
              "' is already in use by another account.";
          } else if (error.code === "auth/invalid-email") {
            useremail_error = error.message;
          } else if (error.code === 'auth/weak-password') {
            pwd1_error = error.message;
          }

          // Send Error back to view
          obs.trigger('error', {
            useremail_error: useremail_error,
            pwd1_error: pwd1_error
          });
        });
      });
      return {obs: obs};
    }

    // Expose these functions
    return {
      login: login,
      signup: signup
    }

  })();
})(riot, firebase, window._rtcApp = window._rtcApp || {});
