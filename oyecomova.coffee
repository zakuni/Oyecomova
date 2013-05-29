PAGES = 'section'
PJAX = false
REPEAT = true 

$ ->
  currentPosition = new Position()  
  appearance = new Appearance()
  appearance.initCSS()
  showPage(currentPosition.get('page'))  

  entireView = new EntireView()

  $('html').keydown (e) ->
    switch e.which
      when 38 # up cursor key
        e.preventDefault()
        entireView.zoomOut()
      when 40 # down cursor key
        e.preventDefault()
        currentPosition.set
          'page': showPage(currentPosition.get('page'))
        entireView.zoomIn()        
      when 33, 37, 75 # pageup, left cursor, k key
        e.preventDefault()
        currentPosition.set
          'page': showPreviousPage(currentPosition.get('page'))
      when 13, 32, 34, 39, 74 # space, enter, pagedown, right cursor, j key
        e.preventDefault()
        currentPosition.set
          'page': showNextPage(currentPosition.get('page'))
      when 36, 48 # home, 0 key
        e.preventDefault()
        currentPosition.set
          'page': showPage(0)
      when 35, 52 # end, $ key
        e.preventDefault()
        currentPosition.set
          'page': showPage(lastPage())

  $(PAGES).click (e) ->
    e.preventDefault()
    clickedPage = $(PAGES).index($(this))
    currentPosition.set
      'page': showPage(clickedPage)
    entireView.zoomIn()

Appearance = Backbone.Model.extend
  defaults:
    direction: 'horizontal'
    
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

Position = Backbone.Model.extend
  defaults:
    page: 0
    level: 0

EntireView = Backbone.View.extend(
  el: 'html'

  zoomIn: ->
    this.$el.css
      'transform': 'scale3d(1.0, 1.0, 1.0)'
      'transition': 'transform 1s ease'
      'transition': '-webkit-transform 1s ease'

  zoomOut: ->
    this.$el.css
      'transform': 'scale3d(0.5, 0.5, 0.5)'
      'transition': 'transform 1s ease' 
      'transition': '-webkit-transform 1s ease'      
)

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
