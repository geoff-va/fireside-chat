;(function(riot, rtcApp) {
  var router = rtcApp.router = rtcApp.router || (function() {
    var routes = [];

    /* Add a regex to `routes` */
    var addRoute = function(regex, func) {
      if (routes.length > 0) {
        for (i=0; i<routes.length; i++) {
          if (routes[i]['regex'] === regex) {
            routes[i]['cb'] = func;
            return;
          }
        }
      }
      routes.push({regex: regex, cb: func});
    }

    /* Search through routes and run cb for first route matching `path` */
    var processView = function(url) {
      var route = null;
      for (i=0; i<routes.length; i++) {
        route = routes[i]
        if (parseUrl(route.regex, url)) {
          // Run CB
          return;
        }
      }
      // No URL match - do something by default?
    }

    /* Parse `path` using `regex` */
    var parseUrl = function(regex, path) {
      var re = new RegExp(regex);
      result = re.exec(path);
      return result;
    }

    return {
      addRoute: addRoute,
      processView: processView,
      parseUrl: parseUrl,
      routes: routes
    };

  }());

}(riot, window._rtcApp = window._rtcApp || {}));


