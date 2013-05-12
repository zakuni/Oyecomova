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
        $('h1').animate
          fontSize: '70'
          1000
          () ->
        $(PAGES).show()
      when 40 # down cursor key
        e.preventDefault()
        level++
        $("#{PAGES}:eq(#{currentPage})").scrollTop()
        $('h1').animate
          fontSize: '200'
          1000
          () -> showPage(currentPage)
      when 37 # left cursor key
        e.preventDefault()
        currentPage = showPreviousPage(currentPage)
      when 39 # right cursor key
        e.preventDefault()
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
