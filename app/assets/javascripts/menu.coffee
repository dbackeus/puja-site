userAgent = window.navigator.userAgent
isIE = userAgent.indexOf("MSIE ") || userAgent.match(/Trident.*rv\:11\./)

$ ->
  $(window).scroll (e) ->
    scrollY = $(window).scrollTop()

    if scrollY >= $("#intro-section").height()
      $(".menu").removeClass("bottom").addClass("top")
    else if scrollY == 0
      $(".menu").removeClass("top").addClass("bottom")
    else
      $(".menu").removeClass("bottom").removeClass("top")

  $(".menu-link").click (e) ->
    e.preventDefault()

    id = $(e.target).attr("href")

    { top } = $(id).position()

    if isIE
      window.scrollTo(0, top)
    else
      $("html body").animate(scrollTop: top)
