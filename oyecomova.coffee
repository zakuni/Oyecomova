PAGES = 'section'
PJAX = false
REPEAT = true 

$ ->
  currentPage = 0
  level = 1

  initCSS()
  showPage(currentPage)  

  $('html').keydown (e) ->
    switch e.which
      when 38 # up cursor key
        e.preventDefault()
        level-- if level > 0
        zoomOut()
        $(PAGES).show()
      when 40 # down cursor key
        e.preventDefault()
        level++
        $("#{PAGES}:eq(#{currentPage})").scrollTop()
        zoomIn()
        showPage(currentPage)
      when 33, 37 # pageup, left cursor key
        e.preventDefault()
        $('h1').removeClass('zoomin').removeClass('zoomout')                
        currentPage = showPreviousPage(currentPage)
      when 13, 32, 34, 39 # space, enter, pagedown, right cursor key
        e.preventDefault()
        $('h1').removeClass('zoomin').removeClass('zoomout')        
        currentPage = showNextPage(currentPage)
      when 36 # home key
        e.preventDefault()
        $('h1').removeClass('zoomin').removeClass('zoomout')
        currentPage = showPage(0)
      when 35 # end key
        e.preventDefault()
        $('h1').removeClass('zoomin').removeClass('zoomout')
        currentPage = showPage(lastPage())

initCSS = () ->
  $('html').css('overflow', 'hidden')
  $(PAGES).parent().css({
    'display': 'flex',        
    ### 
    jquery1.9.1 does not automatically add vendor prefix with 'flex'.
    and also, only Chrome supports 'flex' for now.
    ###
    'display': '-webkit-flex', 
    'flex-wrap': 'nowrap',
    'align-items': 'center',
    'min-width': "#{$(PAGES).size() * 100}%"
  })
  $(PAGES).css({
    'display': 'flex',
    'display': '-webkit-flex',
    'justify-content': 'space-around',
    'align-items': 'center',
    'flex-direction': 'column',
    'width': '100%',
    'min-height': $(window).height(),
    'transition': (index, value) -> 'all 1s ease'
  })
  $('a').hover(
    () -> $(this).css("text-decoration", "underline"), 
    () -> $(this).css("text-decoration", "none")
  )

zoomIn = () ->
  $('h1').removeClass('zoomout')
  $('h1').addClass('zoomin')

zoomOut = () ->
  $('h1').removeClass('zoomin')
  $('h1').addClass('zoomout')

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

lastPage = () -> $(PAGES).size()-1
