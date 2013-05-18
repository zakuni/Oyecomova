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
      when 37 # left cursor key
        e.preventDefault()
        $('h1').removeClass('zoomin').removeClass('zoomout')                
        currentPage = showPreviousPage(currentPage)
      when 39 # right cursor key
        e.preventDefault()
        $('h1').removeClass('zoomin').removeClass('zoomout')        
        currentPage = showNextPage(currentPage)

initCSS = () ->
  $('html').css('overflow', 'hidden')
  $(PAGES).css({
    'width': '100%',
    'height': '100%',
    'transition': (index, value) -> 'all 1s ease'
  })

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
