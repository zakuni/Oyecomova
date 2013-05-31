PAGES = 'section'
PJAX = false
REPEAT = true 

Slide = Backbone.Model.extend
  defaults:
    page: 0

EntireView = Backbone.View.extend
  el: 'html'
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
  showPage: ->
    $(PAGES).css('transform', "translateX(-#{this.model.get('page') * 100}%)")

lastPage = () -> $(PAGES).size()-1

$ ->
  slide = new Slide
  entireView = new EntireView(model: slide)
  entireView.initCSS()

  entireView.listenTo(slide, 'change:page', entireView.showPage)

  $('html').keydown (e) ->
    switch e.which
      when 38 # up cursor key
        e.preventDefault()
        entireView.zoomOut()
      when 40 # down cursor key
        e.preventDefault()
        entireView.zoomIn()        
      when 33, 37, 75 # pageup, left cursor, k key
        e.preventDefault()
        destination = slide.get('page')-1
        if destination < 0
          destination = if REPEAT then lastPage() else 0
        slide.set('page': destination)
      when 13, 32, 34, 39, 74 # space, enter, pagedown, right cursor, j key
        e.preventDefault()
        destination = slide.get('page')+1
        if destination > lastPage()
          destination = if REPEAT then 0 else lastPage()
        slide.set('page': destination)
      when 36, 48 # home, 0 key
        e.preventDefault()
        slide.set('page': 0)
      when 35, 52 # end, $ key
        e.preventDefault()
        slide.set('page': lastPage())

  $(PAGES).click (e) ->
    e.preventDefault()
    clickedPage = $(PAGES).index($(this))
    slide.set
      'page': showPage(clickedPage)
    entireView.zoomIn()
