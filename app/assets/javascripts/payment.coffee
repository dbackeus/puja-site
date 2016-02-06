handler = null

getTotalAmount = ->
  minimum = parseFloat($("#registration_minimum_cost").val())
  extra = parseFloat($("#registration_extra").val()) || 0

  minimum + extra

pay = ->
  handler.open
    amount: getTotalAmount() * 100

initiateStripe = ->
  configuration = $("#stripe-configuration").data()

  handler = StripeCheckout.configure
    name: "Adi Shakti Puja 2016"
    key: configuration.key
    image: configuration.image
    email: configuration.email
    currency: "EUR"

  $(window).on "popstate", ->
    handler.close()

ready = ->
  return unless $("#registration_minimum_cost").length

  initiateStripe()

  $("#pay-button").click (e) ->
    e.preventDefault()

    pay()

  $("#registration_minimum_cost, #registration_extra").moneyField symbol: "€"

  $("#registration_extra").keyup (e) ->
    $("#total-cost").html("#{getTotalAmount()} EUR")

$(document).ready(ready)
$(document).on("page:load", ready)
