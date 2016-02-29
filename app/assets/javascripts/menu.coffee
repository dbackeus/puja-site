$ ->
  $(".menu-link").click (e) ->
    e.preventDefault()

    id = e.target.getAttribute("href")

    { top } = $(id).position()

    $("html body").animate(scrollTop: top)
