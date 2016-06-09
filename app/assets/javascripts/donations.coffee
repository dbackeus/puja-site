handler = null

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

pay = ->
  handler.open
    amount: parseInt($("#donation_amount").val()) * 100

onReceivePaymentToken = (token) ->
  $("#donation_stripe_token").val(token.id)
  $("#pay-button").attr("disabled", true)
  $("#payment-form").submit()

ready = ->
  return unless $("#donation_amount").length

  initiateStripe()

  $("#pay-button").click (e) ->
    e.preventDefault()

    pay()

  $("#donation_amount")
    .moneyField symbol: "€"
    .on 'keypress', (e) ->
      if e.which == 13
        $("#pay-button").click() if e.target.value.length > 0
        return false

$(document).ready(ready)
$(document).on("page:load", ready)
