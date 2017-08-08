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

    /* Chat room interface - load messages/send message */
    var chatRoom = function(urlParams) {
      var obs = riot.observable();
      var roomid = urlParams[1];
      var roomref = firebase.database().ref('rooms/' + roomid);

      // Get room name and pass it to the room
      obs.getRoomName = function() {
        roomref.once('value', (snap) => {
          var roomname = snap.val().name;
          obs.trigger('roomname', roomname);
        });
      }

      // Pass messages into the room
      // TODO: Limit to most recent XX messages
      var msgref = firebase.database().ref('messages/' + roomid);
      obs.getMessages = function() {
        msgref.orderByChild('timestamp')
          .on('child_added', (snap) => {
            var message = snap.val();
            var d = new Date(message.timestamp);
            console.log(d);
            message.timestamp = d.getMonth()+1+"/"+d.getDate()+"/"+d.getFullYear()+" " +
              d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
            console.log(message.timestamp);

            obs.trigger('newMessage', message);
          });
      }

      // Upload a message sent from chat
      obs.on("send", (payload) => {
        var user = firebase.auth().currentUser;
        payload['displayname'] = user.displayName;
        payload['userid'] = user.uid;
        msgref.push(payload).catch((error) => {
          console.log(error);
        });
      });

      return {obs: obs};
    }

    var chatRooms = function(urlParams) {
      var obs = riot.observable();
      var ref = firebase.database().ref('rooms');

      /* Subscribe to room additions */
      obs.addRoom = function() {
        ref.orderByChild('name')
          .on('child_added', function(snap) {
            console.log("child_added right before trigger");

            obs.trigger('addRoom', {id: snap.key, value: message});
        });
      }

      /* Subscribe to removals of rooms */
      obs.deleteRoom = function() {
        ref.orderByChild('name')
          .on('child_removed', function(snap) {
            obs.trigger('deleteRoom', {id: snap.key, value: snap.val()});
        });
      }

      /* Subscribe to changes in room details */
      obs.changeRoom = function() {
        ref.orderByChild('name')
          .on('child_changed', function(snap) {
            obs.trigger('changeRoom', {id: snap.key, value: snap.val()});
        });
      }

      return {obs: obs};
    }

    var addRoom = function(urlParams) {
      var obs = riot.observable();
      var ref = firebase.database().ref('rooms');

      /* Create new room if name doesn't already exist, else trigger error */
      obs.on('addRoom', (data) => {
        ref.orderByChild('name').equalTo(data.roomname)
          .once('value', function(snap) {
            if (snap.val() === null) {
              var newRoom = {
                name: data.roomname,
                description: data.description
            };
              ref.push(newRoom).then(() => {
                obs.trigger('success', {nextView: "#/rooms"});
              });

            } else {
              var error = "Sorry, but " + data.roomname + " already exists!";
              obs.trigger('error', error);
            }
        });
      });

      return {obs: obs};
    }

    // Expose these functions
    return {
      login: login,
      signup: signup,
      chatRoom: chatRoom,
      chatRooms: chatRooms,
      addRoom: addRoom
    }

  })();
})(riot, firebase, window._rtcApp = window._rtcApp || {});
