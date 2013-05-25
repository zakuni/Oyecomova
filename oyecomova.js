// Generated by CoffeeScript 1.6.2
(function() {
  var PAGES, PJAX, REPEAT, initCSS, lastPage, showNextPage, showPage, showPreviousPage, zoomIn, zoomOut;

  PAGES = 'section';

  PJAX = false;

  REPEAT = true;

  $(function() {
    var currentPage, level;

    currentPage = 0;
    level = 1;
    initCSS();
    showPage(currentPage);
    $('html').keydown(function(e) {
      switch (e.which) {
        case 38:
          e.preventDefault();
          if (level > 0) {
            level--;
          }
          zoomOut();
          return $(PAGES).show();
        case 40:
          e.preventDefault();
          level++;
          $("" + PAGES + ":eq(" + currentPage + ")").scrollTop();
          zoomIn();
          return showPage(currentPage);
        case 33:
        case 37:
        case 75:
          e.preventDefault();
          $('h1').removeClass('zoomin').removeClass('zoomout');
          return currentPage = showPreviousPage(currentPage);
        case 13:
        case 32:
        case 34:
        case 39:
        case 74:
          e.preventDefault();
          $('h1').removeClass('zoomin').removeClass('zoomout');
          return currentPage = showNextPage(currentPage);
        case 36:
        case 48:
          e.preventDefault();
          $('h1').removeClass('zoomin').removeClass('zoomout');
          return currentPage = showPage(0);
        case 35:
        case 52:
          e.preventDefault();
          $('h1').removeClass('zoomin').removeClass('zoomout');
          return currentPage = showPage(lastPage());
      }
    });
    return $(PAGES).click(function(e) {
      var clickedPage;

      e.preventDefault();
      clickedPage = $(PAGES).index($(this));
      currentPage = showPage(clickedPage);
      return zoomIn();
    });
  });

  initCSS = function() {
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
    $(PAGES).css({
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
    return $('a').hover(function() {
      return $(this).css("text-decoration", "underline");
    }, function() {
      return $(this).css("text-decoration", "none");
    });
  };

  zoomIn = function() {
    return $('html').css({
      'transform': 'scale3d(1.0, 1.0, 1.0)',
      'transition': 'transform 1s ease',
      'transition': '-webkit-transform 1s ease'
    });
  };

  zoomOut = function() {
    return $('html').css({
      'transform': 'scale3d(0.5, 0.5, 0.5)',
      'transition': 'transform 1s ease',
      'transition': '-webkit-transform 1s ease'
    });
  };

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
    return $(PAGES).css('transform', "translateX(-" + (index * 100) + "%)");
  };

  lastPage = function() {
    return $(PAGES).size() - 1;
  };

}).call(this);
