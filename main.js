// Generated by CoffeeScript 1.6.2
(function() {
  require.config({
    paths: {
      "backbone": "components/backbone/backbone-min",
      "underscore": "components/underscore/underscore-min",
      "jquery": "components/jquery/jquery.min"
    },
    shim: {
      "backbone": {
        deps: ["underscore", "jquery"],
        exports: "Backbone"
      },
      "underscore": {
        exports: "_"
      },
      "jquery": {
        exports: "$"
      }
    }
  });

  require(["backbone", "models/slide"], function(Backbone, Slide) {
    var EntireView, PAGES, PJAX, REPEAT, firstPage, lastPage;

    PAGES = 'section';
    PJAX = false;
    REPEAT = true;
    EntireView = Backbone.View.extend({
      el: 'html',
      events: {
        'keydown': 'onKeyDown'
      },
      initCSS: function() {
        this.$el.css('overflow', 'hidden');
        $(PAGES).parent().css({
          'display': 'flex',
          /* 
          	      jquery1.9.1 does not automatically add vendor prefix with 'flex'.
          	      and also, only Chrome supports 'flex' for now.
          */

          'display': '-webkit-flex',
          'flex-wrap': 'nowrap',
          'align-items': 'center',
          'min-width': "" + ($(PAGES).size() * 100) + "%"
        });
        return $(PAGES).css({
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
        return $(PAGES).css('transform', "translateX(-" + (this.model.get('page') * 100) + "%)");
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
            if (destination < firstPage()) {
              destination = REPEAT ? lastPage() : firstPage();
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
            if (destination > lastPage()) {
              destination = REPEAT ? firstPage() : lastPage();
            }
            return this.model.set({
              'page': destination
            });
          case 36:
          case 48:
            e.preventDefault();
            return this.model.set({
              'page': firstPage()
            });
          case 35:
          case 52:
            e.preventDefault();
            return this.model.set({
              'page': lastPage()
            });
          case 191:
            return e.preventDefault();
        }
      }
    });
    firstPage = function() {
      return 0;
    };
    lastPage = function() {
      return $(PAGES).size() - 1;
    };
    return $(function() {
      var entireView, mediaQueryList, slide;

      slide = new Slide;
      entireView = new EntireView({
        model: slide
      });
      entireView.initCSS();
      entireView.listenTo(slide, 'change:page', entireView.showPage);
      entireView.listenTo(slide, 'change:altitude', entireView.zoom);
      $(PAGES).click(function(e) {
        var clickedPage;

        e.preventDefault();
        clickedPage = $(PAGES).index($(this));
        slide.set({
          'page': clickedPage
        });
        return entireView.zoomIn();
      });
      mediaQueryList = window.matchMedia('print');
      return mediaQueryList.addListener(function(mql) {
        if (mql.matches) {
          return $(PAGES).parent().css({
            'display': 'inline'
          });
        } else {
          return $(PAGES).parent().css({
            'display': 'flex',
            'display': '-webkit-flex'
          });
        }
      });
    });
  });

}).call(this);
