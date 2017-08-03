
;(function() {
  firebase.auth().onAuthStateChanged(function(user) {
    if (user) {
      // Show the Chat Rooms Page
      console.log("Caught a user logging in -- " + user.email);
      riot.mount('chat-rooms');
    } else {
      // Show the login page
      riot.mount('my-login');
      console.log("No User logged in");
    }
  });

  var router = new Router();
  router.addRoute('/test', function() {
    console.log('went to test!');
  });

  /* A most basic router */
  function Router() {
    this.routes = {};

    this.addRoute = function(route, fn) {
      this.routes[route] = fn;
    }

  }
})();


