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

    // Expose these functions
    return {
      login: login
    }

  })();
})(riot, firebase, window._rtcApp = window._rtcApp || {});
