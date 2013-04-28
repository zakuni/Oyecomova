PAGE = 'section'
pjax = false

$ ->
  current = 0
  showPage(current)

  $('html').keydown (e) ->
    switch e.which
      when 38 # up cursor key
        e.preventDefault()
        $('h1').animate
          fontSize: '70'
          1000
          () ->
        $(PAGE).show()
      when 40 # down cursor key
        e.preventDefault()
        $("#{PAGE}:eq(#{current})").scrollTop()
        $('h1').animate
          fontSize: '200'
          1000
          () -> showPage(current)
      when 37 # left cursor key
        e.preventDefault()
        current-- if current > 0
        showPage(current)
      when 39 # right cursor key
        e.preventDefault()
        current++ if current < $('h1').size()-1
        showPage(current)

showPage = (index) ->
  $(PAGE).hide();
  $("#{PAGE}:eq(#{index})").show()
