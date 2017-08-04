;(function(riot, rtcApp) {
  var router = rtcApp.router = rtcApp.router || (function() {
    var routes = [];
    var currentTag = null;

    /* Add a regex to `routes` */
    var addRoute = function(regex, location, name) {
      if (routes.length > 0) {
        for (i=0; i<routes.length; i++) {
          if (routes[i]['regex'] === regex) {
            routes[i]['location'] = location;
            routes[i]['name'] = name;
            return;
          }
        }
      }
      routes.push({regex: regex, location: location, name: name});
    }

    /* Search through routes and run cb for first route matching `path` */
    var processView = function(url) {
      // Unmount the currently mounted tag to make room for next view
      if (currentTag !== null) {
        currentTag[0].unmount(true);
        currentTag = null;
      };

      console.log("processing view");
      var route = null;
      for (i=0; i<routes.length; i++) {
        route = routes[i]
        params = parseUrl(route.regex, url)
        if (params) {
          // Maybe all riot rendering should be done somewhere else ...
          riot.compile(route.location, function() {
            console.log("loading: " + route.name);
            console.log("using params: " + params);
            currentTag = riot.mount(route.name, params);
          });
          return;
        }
      }
      console.log("No matching views for url");
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


