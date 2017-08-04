;(function(window, document, firebase, riot, rtcApp) {
  var app = rtcApp.app = rtcApp.all || (function() {
    var router = rtcApp.router;

    /* View Routes */
    router.addRoute("^#/login$", 'tags/my-login.tag', 'my-login');
    router.addRoute("^#/signup$", 'tags/sign-up.tag', 'sign-up');
    router.addRoute("^#/rooms$", 'tags/chat-rooms.tag', 'chat-rooms');
    router.addRoute("^#/rooms/create", 'tags/add-room.tag', 'add-room');
    router.addRoute("^#/room/([a-zA-Z0-9._-]+)$", 'tags/chat-room.tag', 'chat-room');

    /* Watch for changes in the hash*/
    window.addEventListener('hashchange', function(e) {
      router.processView(window.location.hash);
    });

    riot.mount('my-nav'); // always keep nav mounted
    router.processView(window.location.hash);

  }());

}(window, document, firebase, riot, window._rtcApp = window._rtcApp || {}));
