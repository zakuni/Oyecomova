class EntireView extends Backbone.View
  el: 'html'
  events:
    'keydown': 'onKeyDown'
  initCSS: ->
    @$el.css('overflow', 'hidden')
    $(@options.pages).parent().css
      'display': 'flex'       
      ### 
      jquery1.10.1 does not automatically add vendor prefix with 'flex'.
      and also, only Chrome supports 'flex' for now.
      ###
      'display': '-webkit-flex'
      'flex-wrap': 'nowrap'
      'align-items': 'center'
      'min-width': "#{$(@options.pages).size() * 100}%"
    $(@options.pages).css
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
    @$el.css
      'transform': "scale3d(#{x}, #{y}, #{z})"
  zoomIn: ->
    x = y = z = 1    
    @$el.css
      'transform': "scale3d(#{x}, #{y}, #{z})"      
      'transition': 'transform 1s ease'
      'transition': '-webkit-transform 1s ease'
  zoomOut: ->
    x = y = z = 0.5    
    @$el.css
      'transform': "scale3d(#{x}, #{y}, #{z})"
      'transition': 'transform 1s ease' 
      'transition': '-webkit-transform 1s ease'
  showPage: ->
    $(@options.pages).css('transform', "translateX(-#{@model.get('page') * 100}%)")
  onKeyDown: (e)->
    switch e.which
      when 38 # up cursor key
        e.preventDefault()
        @zoomOut()
      when 40 # down cursor key
        e.preventDefault()
        @zoomIn()        
      when 33, 37, 75 # pageup, left cursor, k key
        e.preventDefault()
        destination = @model.get('page')-1
        if destination < @firstPage()
          destination = if @options.repeat then @lastPage() else @firstPage()
        @model.set('page': destination)
      when 13, 32, 34, 39, 74 # space, enter, pagedown, right cursor, j key
        e.preventDefault()
        destination = @model.get('page')+1
        if destination > @lastPage()
          destination = if @options.repeat then @firstPage() else @lastPage()
        @model.set('page': destination)
      when 36, 48 # home, 0 key
        e.preventDefault()
        @model.set('page': @firstPage())
      when 35, 52 # end, $ key
        e.preventDefault()
        @model.set('page': @lastPage())
      when 191 # ? key
        e.preventDefault()
  firstPage: () -> 0
  lastPage: () -> $(@options.pages).size()-1