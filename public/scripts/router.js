/* Router - handles url hash pattern matching and View display */
;(function(riot, rtcApp) {
  var router = rtcApp.router = rtcApp.router || (function() {
    var routes = [];
    var currentTag = null;
    var defaultRoute = null;

    /* Sets the default route to be executed if no regex matches occur */
    var setDefaultRoute = function(regex, location, name, cb) {
      defaultRoute = {regex: regex, location: location, name: name, cb: cb};
    }

    /* Add a route to 'routes' array for future use */
    var addRoute = function(regex, location, name, cb) {
      // Replace route if it already exists in routes array
      for (i=0; i<routes.length; i++) {
        if (routes[i]['regex'] === regex) {
          routes[i]['location'] = location;
          routes[i]['name'] = name;
          routes[i]['cb'] = cb;
          return;
        }
      }
      routes.push({regex: regex, location: location, name: name, cb: cb});
    }

    /* UnMount `currentTag` to make room for next View */
    var removeCurrentTag = function() {
      if (currentTag !== null) {
        currentTag.unmount(true);
        currentTag = null;
      }
    }

    /* Checks routes[] for regex against url, executes callback, displays view */
    var processView = function(url) {
      removeCurrentTag();
      var route = null;

      // Find if any routes regex match url
      for (i=0; i<routes.length; i++) {
        route = routes[i]
        urlParams = parseUrl(route.regex, url)
        if (urlParams) {
          options = route.cb(urlParams);

          // TODO: All rendering could be broken out somewhere else?
          riot.compile(route.location, function() {
            currentTag = riot.mount(route.name, {urlParams: urlParams, interface: options})[0];
          });
          return;
        }
      }

      // No matching routes; Execute defaultRoute
      if (defaultRoute) {
        options = defaultRoute.cb(urlParams);
        riot.compile(defaultRoute.location, function() {
          currentTag = riot.mount(defaultRoute.name,
            {urlParams: urlParams, interface: options})[0];
        });
      }
    }

    /* Parse `path` using `regex` */
    var parseUrl = function(regex, path) {
      var re = new RegExp(regex);
      result = re.exec(path);
      return result;
    }

    // Expose the following
    return {
      addRoute: addRoute,
      processView: processView,
      parseUrl: parseUrl,
      setDefaultRoute: setDefaultRoute
    };

  }());

}(riot, window._rtcApp = window._rtcApp || {}));


