PAGES = 'section'
pjax = false

$ ->
  currentPage = 0
  level = 1
  showPage(currentPage)

  $('html').keydown (e) ->
    switch e.which
      when 38 # up cursor key
        e.preventDefault()
        level-- if level > 0
        $('h1').removeClass('zoomin')
        $('h1').addClass('zoomout')
        $(PAGES).show()
      when 40 # down cursor key
        e.preventDefault()
        level++
        $("#{PAGES}:eq(#{currentPage})").scrollTop()
        $('h1').removeClass('zoomout')
        $('h1').addClass('zoomin')
        showPage(currentPage)
      when 37 # left cursor key
        e.preventDefault()
        $('h1').removeClass('zoomin').removeClass('zoomout')
        currentPage = showPreviousPage(currentPage)
      when 39 # right cursor key
        e.preventDefault()
        $('h1').removeClass('zoomin').removeClass('zoomout')        
        currentPage = showNextPage(currentPage)

showPreviousPage = (page) ->
  page-- if page > 0
  showPage(page)
  return page

showNextPage = (page) ->
  page++ if page < $(PAGES).size()-1
  showPage(page)
  return page

showPage = (index) ->
  $(PAGES).hide();
  $("#{PAGES}:eq(#{index})").show()
