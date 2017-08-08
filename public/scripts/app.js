/* Main Application entry point */
;(function(window, document, firebase, riot, rtcApp) {
  var app = rtcApp.app = rtcApp.app || (function() {
    var router = rtcApp.router;

    /* View Routes */
    router.addRoute("^#/login$", 'tags/my-login.tag', 'my-login', rtcApp.routes.login);
    router.addRoute("^#/signup$", 'tags/sign-up.tag', 'sign-up', rtcApp.routes.signup);
    router.addRoute("^#/rooms$", 'tags/chat-rooms.tag', 'chat-rooms', rtcApp.routes.chatRooms);
    router.addRoute("^#/rooms/create", 'tags/add-room.tag', 'add-room', rtcApp.routes.addRoom);
    router.addRoute("^#/room/([a-zA-Z0-9._-]+)$", 'tags/chat-room.tag', 'chat-room', rtcApp.routes.chatRoom);
    router.setDefaultRoute('', 'tags/not-found.tag', 'not-found', (urlParams) => {return {};});

    /* Watch for changes in the hash so we can process manually changed views */
    window.addEventListener('hashchange', function(e) {
      // Allow auth'd user to go to target address, non auth'd to login
      if (window.location.hash !== "#/signup" && !firebase.auth().currentUser) {
        router.processView("#/login");
        history.pushState({}, null, "#/login");
      } else {
        router.processView(window.location.hash);
      }
    });

    // Redirect user to login if they aren't auth'd
    // This will fire once on page load and again if user signs out or in
    // with another signin name
    firebase.auth().onAuthStateChanged(function(user) {
      if (!user) {
        router.processView("#/login");
        history.pushState({}, null, "#/login");
      } else {
        router.processView(window.location.hash);
      }

    });

    // Nav (header, really) will always be mounted
    riot.mount('my-nav');
  }());

}(window, document, firebase, riot, window._rtcApp = window._rtcApp || {}));
