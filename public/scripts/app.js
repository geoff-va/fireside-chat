;(function(window, firebase, riot, rtcApp) {
  var app = rtcApp.app = rtcApp.all || (function() {

  }());


  //riot.compile(function() {
    //tags.push(riot.mount('my-login', {auth: auth}));
    //console.log(tags);
  //});


  //firebase.auth().onAuthStateChanged(function(user) {
    //if (user) {
      //// Show the Chat Rooms Page
      //console.log("Caught a user logging in -- " + user.email);
      //auth.trigger('signin');
      //riot.compile(function() {
        //tags.push(riot.mount('chat-rooms'));
      //});
    //} else {
      //// Show the login page
      //console.log("No User logged in");
    //}
  //});

}(window, firebase, riot, window._rtcApp = window._rtcApp || {}));
