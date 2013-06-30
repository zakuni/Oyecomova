// Generated by CoffeeScript 1.6.2
(function() {
  define(["backbone"], function(Backbone) {
    var EntireView;

    return EntireView = Backbone.View.extend({
      el: 'html',
      events: {
        'keydown': 'onKeyDown'
      },
      initCSS: function() {
        this.$el.css('overflow', 'hidden');
        $(this.options.pages).parent().css({
          'display': 'flex',
          /* 
          jquery1.9.1 does not automatically add vendor prefix with 'flex'.
          and also, only Chrome supports 'flex' for now.
          */

          'display': '-webkit-flex',
          'flex-wrap': 'nowrap',
          'align-items': 'center',
          'min-width': "" + ($(this.options.pages).size() * 100) + "%"
        });
        return $(this.options.pages).css({
          'display': 'flex',
          'display': '-webkit-flex',
          'justify-content': 'space-around',
          'align-items': 'center',
          'flex-direction': 'column',
          'width': '100%',
          'min-height': $(window).height(),
          'transition': function(index, value) {
            return 'all 1s ease';
          },
          'page-break-after': 'always'
        });
      },
      zoom: function(level) {
        var x, y, z;

        x = y = z = 1 / level;
        return this.$el.css({
          'transform': "scale3d(" + x + ", " + y + ", " + z + ")"
        });
      },
      zoomIn: function() {
        var x, y, z;

        x = y = z = 1;
        return this.$el.css({
          'transform': "scale3d(" + x + ", " + y + ", " + z + ")",
          'transition': 'transform 1s ease',
          'transition': '-webkit-transform 1s ease'
        });
      },
      zoomOut: function() {
        var x, y, z;

        x = y = z = 0.5;
        return this.$el.css({
          'transform': "scale3d(" + x + ", " + y + ", " + z + ")",
          'transition': 'transform 1s ease',
          'transition': '-webkit-transform 1s ease'
        });
      },
      showPage: function() {
        return $(this.options.pages).css('transform', "translateX(-" + (this.model.get('page') * 100) + "%)");
      },
      onKeyDown: function(e) {
        var destination;

        switch (e.which) {
          case 38:
            e.preventDefault();
            return this.zoomOut();
          case 40:
            e.preventDefault();
            return this.zoomIn();
          case 33:
          case 37:
          case 75:
            e.preventDefault();
            destination = this.model.get('page') - 1;
            if (destination < this.firstPage()) {
              destination = this.options.repeat ? this.lastPage() : this.firstPage();
            }
            return this.model.set({
              'page': destination
            });
          case 13:
          case 32:
          case 34:
          case 39:
          case 74:
            e.preventDefault();
            destination = this.model.get('page') + 1;
            if (destination > this.lastPage()) {
              destination = this.options.repeat ? this.firstPage() : this.lastPage();
            }
            return this.model.set({
              'page': destination
            });
          case 36:
          case 48:
            e.preventDefault();
            return this.model.set({
              'page': this.firstPage()
            });
          case 35:
          case 52:
            e.preventDefault();
            return this.model.set({
              'page': this.lastPage()
            });
          case 191:
            return e.preventDefault();
        }
      },
      firstPage: function() {
        return 0;
      },
      lastPage: function() {
        return $(this.options.pages).size() - 1;
      }
    });
  });

}).call(this);