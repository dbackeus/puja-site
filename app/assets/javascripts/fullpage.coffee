refreshHeight = ->
  height = $(window).height()
  height = 500 if height < 500
  $("#intro-section").height height
  $(".title-holder").css "top", (height - $(".title-holder").height()) / 2

$(document).ready(refreshHeight)
$(window).resize(refreshHeight)
