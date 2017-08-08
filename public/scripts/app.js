;(function(window, document, firebase, riot, rtcApp) {
  var app = rtcApp.app = rtcApp.app || (function() {
    var router = rtcApp.router;

    /* View Routes */
    router.addRoute("^#/login$", 'tags/my-login.tag', 'my-login', rtcApp.routes.login);
    router.addRoute("^#/signup$", 'tags/sign-up.tag', 'sign-up', rtcApp.routes.signup);
    //router.addRoute("^#/rooms$", 'tags/chat-rooms.tag', 'chat-rooms');
    //router.addRoute("^#/rooms/create", 'tags/add-room.tag', 'add-room');
    router.addRoute("^#/room/([a-zA-Z0-9._-]+)$", 'tags/chat-room.tag', 'chat-room', rtcApp.routes.chatRoom);

    /* Watch for changes in the hash*/
    window.addEventListener('hashchange', function(e) {
      if (window.location.hash !== "#/signup" && !firebase.auth().currentUser) {
        router.processView("#/login");
        history.pushState({}, null, "#/login");
      } else {
        router.processView(window.location.hash);
      }
    });

    // Redirect user to login if they aren't auth'd
    firebase.auth().onAuthStateChanged(function(user) {
      if (!user) {
        router.processView("#/login");
        history.pushState({}, null, "#/login");
      } else {
        router.processView(window.location.hash);
      }

    });

    riot.mount('my-nav'); // always keep nav mounted

  }());

}(window, document, firebase, riot, window._rtcApp = window._rtcApp || {}));
