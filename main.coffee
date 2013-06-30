$ ->
  PAGES = 'section'
  REPEAT = true
  PJAX = false

  slide = new Slide
  entireView = new EntireView(
    model: slide
    pages: PAGES
    repeat: REPEAT
    )
  entireView.initCSS()
  entireView.listenTo(slide, 'change:page', entireView.showPage)
  entireView.listenTo(slide, 'change:altitude', entireView.zoom)

  $(PAGES).click (e) ->
    e.preventDefault()
    clickedPage = $(PAGES).index($(this))
    slide.set('page': clickedPage)
    entireView.zoomIn()

  mediaQueryList = window.matchMedia('print')
  mediaQueryList.addListener (mql) ->
    if (mql.matches)
      $(PAGES).parent().css
        'display': 'inline'
    else
      $(PAGES).parent().css
        'display': 'flex'
        'display': '-webkit-flex'