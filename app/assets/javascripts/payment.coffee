handler = null

getTotalAmount = ->
  minimum = parseFloat($("#registration_minimum_cost").val())
  extra = parseFloat($("#registration_extra").val()) || 0

  minimum + extra

pay = ->
  handler.open
    amount: getTotalAmount() * 100

onReceivePaymentToken = (token) ->
  $("#registration_stripe_token").val(token.id)
  $("#pay-button").attr("disabled", true)
  $("#payment-form").submit()

onExtraChange = (e) ->
  numberOfDonators = $("[data-is-donating=true]").length
  extraPerParticipant = (parseInt(e.target.value) / numberOfDonators) || 0

  $("[data-is-donating=true]").html("€#{Math.round(extraPerParticipant)}")
  $("#total-cost").html("€#{getTotalAmount()}.00")

initiateStripe = ->
  unless window.StripeCheckout
    console.warn "StripeCheckout not available, skipping..."
    return

  configuration = $("#stripe-configuration").data()

  handler = StripeCheckout.configure
    name: "Adi Shakti Puja 2016"
    key: configuration.key
    image: configuration.image
    email: configuration.email
    currency: "EUR"
    token: onReceivePaymentToken
    allowRememberMe: false

  $(window).on "popstate", ->
    handler.close()

ready = ->
  return unless $("#registration_minimum_cost").length

  initiateStripe()

  $("#pay-button").click (e) ->
    e.preventDefault()

    pay()

  $("#registration_minimum_cost, #registration_extra").moneyField symbol: "€"

  $("#registration_extra").keyup onExtraChange

$(document).ready(ready)
$(document).on("page:load", ready)
