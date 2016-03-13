refreshHeight = ->
  $("#intro-section").height $(window).height()

$(document).ready(refreshHeight)
$(window).resize(refreshHeight)
