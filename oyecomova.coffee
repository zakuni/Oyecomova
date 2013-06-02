PAGES = 'section'
PJAX = false
REPEAT = true 

Slide = Backbone.Model.extend
  defaults:
    page: 0
    altitude: 0

EntireView = Backbone.View.extend
  el: 'html'
  events:
    'keydown': 'onKeyDown'
  initCSS: ->
    this.$el.css('overflow', 'hidden')
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
      'page-break-after': 'always'
  zoom: (level) ->
    x = y = z = 1/level    
    this.$el.css
      'transform': "scale3d(#{x}, #{y}, #{z})"
  zoomIn: ->
    x = y = z = 1    
    this.$el.css
      'transform': "scale3d(#{x}, #{y}, #{z})"      
      'transition': 'transform 1s ease'
      'transition': '-webkit-transform 1s ease'
  zoomOut: ->
    x = y = z = 0.5    
    this.$el.css
      'transform': "scale3d(#{x}, #{y}, #{z})"
      'transition': 'transform 1s ease' 
      'transition': '-webkit-transform 1s ease'
  showPage: ->
    $(PAGES).css('transform', "translateX(-#{this.model.get('page') * 100}%)")
  onKeyDown: (e)->
    switch e.which
      when 38 # up cursor key
        e.preventDefault()
        this.zoomOut()
      when 40 # down cursor key
        e.preventDefault()
        this.zoomIn()        
      when 33, 37, 75 # pageup, left cursor, k key
        e.preventDefault()
        destination = this.model.get('page')-1
        if destination < firstPage()
          destination = if REPEAT then lastPage() else firstPage()
        this.model.set('page': destination)
      when 13, 32, 34, 39, 74 # space, enter, pagedown, right cursor, j key
        e.preventDefault()
        destination = this.model.get('page')+1
        if destination > lastPage()
          destination = if REPEAT then firstPage() else lastPage()
        this.model.set('page': destination)
      when 36, 48 # home, 0 key
        e.preventDefault()
        this.model.set('page': firstPage())
      when 35, 52 # end, $ key
        e.preventDefault()
        this.model.set('page': lastPage())

firstPage = () -> 0
lastPage = () -> $(PAGES).size()-1

$ ->
  slide = new Slide
  entireView = new EntireView(model: slide)
  entireView.initCSS()

  entireView.listenTo(slide, 'change:page', entireView.showPage)

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