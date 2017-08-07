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

    /* Add a regex to `routes` */
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

    /* Checks routes[] for regex match against `url` and executes callback */
    var processView = function(url) {
      var route = null;

      // Find if any routes regex match url
      for (i=0; i<routes.length; i++) {
        route = routes[i]
        urlParams = parseUrl(route.regex, url)
        if (urlParams) {
          options = route.cb();

          // Maybe all riot rendering should be done somewhere else ...
          riot.compile(route.location, function() {
            currentTag = riot.mount(route.name, {urlParams: urlParams, interface: options});
          });
          return;
        }
      }

      // No matching routes; Execute defaultRoute
      if (defaultRoute) {
        console.log("No matching views for url");
        riot.compile(defaultRoute.location, function() {
          currentTag = riot.mount(defaultRoute.name,
            {urlParams: urlParams, interface: options});
        });
      }
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


