$ ->
  current = 0

  $('html').keyup (e) ->
    switch e.which
      when 38 # up cursor key
        $('h1').animate
          fontSize: '70', 1000, () ->
        $('section').show()
      when 40 # down cursor key
        $('section#current').scrollTop()
        $("section:eq(#{current})").scrollTop()
        $('h1').animate
          fontSize: '200', 1000, () -> showPage(current)
      when 37 # left cursor key
        current-- if current > 0
        showPage(current)
      when 39 # right cursor key
        current++ if current < $('h1').size()-1
        showPage(current)

showPage = (index) ->
  $('section').hide();
  $('section:eq(' + index + ')').show()
  $("section:eq(#{index})").show()
