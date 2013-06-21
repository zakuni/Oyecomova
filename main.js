// Generated by CoffeeScript 1.6.2
(function() {
  require.config({
    paths: {
      "backbone": "components/backbone/backbone-min.js",
      "underscore": "components/underscore/underscore-min.js",
      "jquery": "components/jquery/jquery.min.js"
    },
    shim: {
      "backbone": {
        deps: ["underscore", "jquery"],
        exports: "Backbone"
      }
    }
  });

}).call(this);
