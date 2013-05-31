// Generated by CoffeeScript 1.6.2
(function() {
  var EntireView, PAGES, PJAX, Position, REPEAT, Slide, lastPage, showNextPage, showPage, showPreviousPage;

  PAGES = 'section';

  PJAX = false;

  REPEAT = true;

  $(function() {
    var entireView, slide;

    slide = new Slide;
    entireView = new EntireView({
      model: slide
    });
    entireView.initCSS();
    entireView.listenTo(slide, 'change:page', entireView.showPage);
    $('html').keydown(function(e) {
      var destination;

      switch (e.which) {
        case 38:
          e.preventDefault();
          return entireView.zoomOut();
        case 40:
          e.preventDefault();
          entireView.showPage();
          return entireView.zoomIn();
        case 33:
        case 37:
        case 75:
          e.preventDefault();
          destination = slide.get('page') - 1;
          if (destination < 0) {
            destination = REPEAT ? lastPage() : 0;
          }
          return slide.set({
            'page': destination
          });
        case 13:
        case 32:
        case 34:
        case 39:
        case 74:
          e.preventDefault();
          destination = slide.get('page') + 1;
          if (destination > lastPage()) {
            destination = REPEAT ? 0 : lastPage();
          }
          return slide.set({
            'page': destination
          });
        case 36:
        case 48:
          e.preventDefault();
          return slide.set({
            'page': 0
          });
        case 35:
        case 52:
          e.preventDefault();
          return slide.set({
            'page': lastPage()
          });
      }
    });
    return $(PAGES).click(function(e) {
      var clickedPage;

      e.preventDefault();
      clickedPage = $(PAGES).index($(this));
      slide.set({
        'page': showPage(clickedPage)
      });
      return entireView.zoomIn();
    });
  });

  Position = Backbone.Model.extend({
    defaults: {
      page: 0,
      level: 0
    }
  });

  EntireView = Backbone.View.extend({
    el: 'html',
    initCSS: function() {
      $('html').css('overflow', 'hidden');
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
        }
      });
    },
    zoomIn: function() {
      return this.$el.css({
        'transform': 'scale3d(1.0, 1.0, 1.0)',
        'transition': 'transform 1s ease',
        'transition': '-webkit-transform 1s ease'
      });
    },
    zoomOut: function() {
      return this.$el.css({
        'transform': 'scale3d(0.5, 0.5, 0.5)',
        'transition': 'transform 1s ease',
        'transition': '-webkit-transform 1s ease'
      });
    },
    showPage: function() {
      console.log('showPage' + this.model.get('page'));
      return $(PAGES).css('transform', "translateX(-" + (this.model.get('page') * 100) + "%)");
    }
  });

  Slide = Backbone.Model.extend({
    defaults: {
      page: 0
    }
  });

  showPreviousPage = function(page) {
    if (page > 0) {
      page--;
    } else {
      if (REPEAT) {
        page = lastPage();
      }
    }
    showPage(page);
    return page;
  };

  showNextPage = function(page) {
    if (page < lastPage()) {
      page++;
    } else {
      if (REPEAT) {
        page = 0;
      }
    }
    showPage(page);
    return page;
  };

  showPage = function(index) {
    $(PAGES).css('transform', "translateX(-" + (index * 100) + "%)");
    return index;
  };

  lastPage = function() {
    return $(PAGES).size() - 1;
  };

}).call(this);
