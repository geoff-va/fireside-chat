;(function(riot, firebase, rtcApp) {
  var routes = rtcApp.routes = rtcApp.routes || (function() {

    /* Login view function */
    var login = function(urlParams) {
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
    var signup = function(urlParams) {
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

    /* Load messages into a chat room */
    var chatRoom = function(urlParams) {
      var obs = riot.observable();
      var roomid = urlParams[1];
      var roomref = firebase.database().ref('rooms/' + roomid);

      // Get the name of the room
      roomref.once('value', (snap) => {
        var roomname = snap.val().name;
        obs.trigger('roomname', roomname);
      });

      // Send the room name to the room

      // Pass messages into the room
      // TODO: Limit to most recent XX messages
      var msgref = firebase.database().ref('messages/' + roomid);
      msgref.orderByChild('timestamp')
        .on('child_added', (snap) => {
          obs.trigger('newMessage', snap.val());
        });

      return {obs: obs};
    }

    // Expose these functions
    return {
      login: login,
      signup: signup,
      chatRoom: chatRoom
    }

  })();
})(riot, firebase, window._rtcApp = window._rtcApp || {});
