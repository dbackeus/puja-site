handler = null

getTotalAmount = ->
  numberOfDonators = $("[data-is-donating=true]").length
  minimum = parseInt($("#registration_minimum_cost").val())
  extra = parseInt($(".registration_extra_per_participant input[type=radio]:checked").val()) * numberOfDonators

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
  extraPerParticipant = e.target.value
  maybeEmoji = switch extraPerParticipant
    when "84"
      " <span class='glyphicon glyphicon-star' style='color: orange'></span>"
    when "108"
      " <span class='glyphicon glyphicon-heart' style='color: #e9677d'></span>"
    else
      ""

  $("[data-is-donating=true]").html("€#{extraPerParticipant}#{maybeEmoji}")
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

  $(".registration_extra_per_participant input[type=radio]").change onExtraChange

$(document).ready(ready)
$(document).on("page:load", ready)
