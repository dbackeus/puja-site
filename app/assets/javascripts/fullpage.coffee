ready = ->
  $("#fullpage").fullpage
    verticalCentered: false
    anchors: [
      "intro"
      "welcome"
      "venue"
      "travel"
      "visa"
      "registration"
    ]

    loopHorizontal: false

    onLeave: (index, nextIndex, direction) ->
      if nextIndex == 1
        $(".menu").removeClass("top")
      else
        $(".menu").removeClass("bottom")

    afterLoad: (anchorLink, index) ->
      $(".menu-link").removeClass("active")
      $("a[href*=#{anchorLink}]").addClass("active")

      if index == 1
        $(".menu").removeClass("top").addClass("bottom")
      else
        $(".menu").removeClass("bottom").addClass("top")

$(document).ready(ready)
$(document).on("page:load", ready)
