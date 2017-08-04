;(function(window, document, firebase, riot, rtcApp) {
  var app = rtcApp.app = rtcApp.all || (function() {
    var router = rtcApp.router;

    router.addRoute("^#/login$", 'tags/my-login.tag', 'my-login');
    router.addRoute("^#/signup$", 'tags/sign-up.tag', 'sign-up');

    window.addEventListener('hashchange', function(e) {
      router.processView(window.location.hash);
    });

    riot.mount('my-nav'); // always keep this mounted

    // Load appropriate part of app based on hash
    console.log("page load location: " + window.location.hash);
    router.processView(window.location.hash);

    function unmountTags(tags) {
      for (i=0; i<tags.length; i++) {
        tags[i].unmount();
      }
    }

  }());

}(window, document, firebase, riot, window._rtcApp = window._rtcApp || {}));
