PAGES = 'section'
PJAX = false
REPEAT = true 

$ ->
  currentPage = 0
  level = 1

  appearance = new Appearance()
  appearance.initCSS()
  showPage(currentPage)  

  $('html').keydown (e) ->
    switch e.which
      when 38 # up cursor key
        e.preventDefault()
        level-- if level > 0
        zoomOut()
      when 40 # down cursor key
        e.preventDefault()
        level++
        currentPage = showPage(currentPage)
        zoomIn()        
      when 33, 37, 75 # pageup, left cursor, k key
        e.preventDefault()
        currentPage = showPreviousPage(currentPage)
      when 13, 32, 34, 39, 74 # space, enter, pagedown, right cursor, j key
        e.preventDefault()
        currentPage = showNextPage(currentPage)
      when 36, 48 # home, 0 key
        e.preventDefault()
        currentPage = showPage(0)
      when 35, 52 # end, $ key
        e.preventDefault()
        currentPage = showPage(lastPage())

  $(PAGES).click (e) ->
    e.preventDefault()
    clickedPage = $(PAGES).index($(this))
    currentPage = showPage(clickedPage)
    zoomIn()

Appearance = Backbone.Model.extend
  initCSS: ->
    $('html').css('overflow', 'hidden')
    $(PAGES).parent().css
      'display': 'flex'       
      ### 
      jquery1.9.1 does not automatically add vendor prefix with 'flex'.
      and also, only Chrome supports 'flex' for now.
      ###
      'display': '-webkit-flex'
      'flex-wrap': 'nowrap'
      'align-items': 'center'
      'min-width': "#{$(PAGES).size() * 100}%"

  $(PAGES).css
    'display': 'flex'
    'display': '-webkit-flex'
    'justify-content': 'space-around'
    'align-items': 'center'
    'flex-direction': 'column'
    'width': '100%'
    'min-height': $(window).height()
    'transition': (index, value) -> 'all 1s ease'

zoomIn = () ->
  $('html').css
    'transform': 'scale3d(1.0, 1.0, 1.0)'
    'transition': 'transform 1s ease'
    'transition': '-webkit-transform 1s ease'

zoomOut = () ->
  $('html').css
    'transform': 'scale3d(0.5, 0.5, 0.5)'
    'transition': 'transform 1s ease' 
    'transition': '-webkit-transform 1s ease'

showPreviousPage = (page) ->
  if page > 0
    page--
  else
    page = lastPage() if REPEAT
  showPage(page)
  return page

showNextPage = (page) ->
  if page < lastPage()
    page++ 
  else
    page = 0 if REPEAT
  showPage(page)
  return page

showPage = (index) ->
  $(PAGES).css('transform', "translateX(-#{index * 100}%)")
  return index

lastPage = () -> $(PAGES).size()-1
