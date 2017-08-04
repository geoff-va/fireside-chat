;(function(riot, rtcApp) {
  var router = rtcApp.router = rtcApp.router || (function() {
    var routes = [];

    /* Add a route */
    var addRoute = function(path, func) {
      for (i=0; routes.length; i++) {
        if (routes[i]['path'] === path) {
          routes[i]['cb'] = func;
          return;
        }
      }
      routes.push({path: path, cb: func});
    }

    var processView = function(path) {

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
      parseUrl: parseUrl
    };

  }());

}(riot, window._rtcApp = window._rtcApp || {}));


