define ["backbone"], (Backbone) ->
  EntireView = Backbone.View.extend
    el: 'html'
    events:
      'keydown': 'onKeyDown'
    initCSS: ->
      this.$el.css('overflow', 'hidden')
      $(this.options.pages).parent().css
        'display': 'flex'       
        ### 
        jquery1.9.1 does not automatically add vendor prefix with 'flex'.
        and also, only Chrome supports 'flex' for now.
        ###
        'display': '-webkit-flex'
        'flex-wrap': 'nowrap'
        'align-items': 'center'
        'min-width': "#{$(this.options.pages).size() * 100}%"
      $(this.options.pages).css
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
      $(this.options.pages).css('transform', "translateX(-#{this.model.get('page') * 100}%)")
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
          if destination < this.firstPage()
            destination = if this.options.repeat then this.lastPage() else this.firstPage()
          this.model.set('page': destination)
        when 13, 32, 34, 39, 74 # space, enter, pagedown, right cursor, j key
          e.preventDefault()
          destination = this.model.get('page')+1
          if destination > this.lastPage()
            destination = if this.options.repeat then this.firstPage() else this.lastPage()
          this.model.set('page': destination)
        when 36, 48 # home, 0 key
          e.preventDefault()
          this.model.set('page': this.firstPage())
        when 35, 52 # end, $ key
          e.preventDefault()
          this.model.set('page': this.lastPage())
        when 191 # ? key
          e.preventDefault()
    firstPage: () -> 0
    lastPage: () -> $(this.options.pages).size()-1