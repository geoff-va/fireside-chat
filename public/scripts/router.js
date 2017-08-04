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
      if (currentTag !== null) {
        currentTag[0].unmount(true);
        console.log("Unmounted Tag");
        currentTag = null;
      };
      var route = null;
      for (i=0; i<routes.length; i++) {
        route = routes[i]
        if (parseUrl(route.regex, url)) {
          // URL match - ru CB
          console.log("Running cb for" + route.regex);
          riot.compile(route.location, function() {
            currentTag = riot.mount(route.name);
            console.log(currentTag);
          });
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


