refreshHeight = ->
  console.log "refreshing..."
  $("#intro-section").height $(window).height()

$(document).scroll (e) ->
  if window.scrollY >= $("#intro-section").height()
    $(".menu").removeClass("bottom").addClass("top")
  else if window.scrollY == 0
    $(".menu").removeClass("top").addClass("bottom")
  else
    $(".menu").removeClass("bottom").removeClass("top")

$(document).ready(refreshHeight)
$(window).resize(refreshHeight)
