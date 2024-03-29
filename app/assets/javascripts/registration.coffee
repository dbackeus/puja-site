# nested forms inspired by http://davidlesches.com/blog/rails-nested-forms-using-jquery-and-simpleform

disableFullyBookedOptions = ->
  $(".registration_accommodation .radio").each ->
    $formGroup = $(@)

    if parseInt($(@).find("[data-places-left]").data("placesLeft")) <= 0
      $formGroup.find("input").attr("disabled", true)

removeParticipant = (e) ->
  e.preventDefault()

  $(this).parents('.duplicatable_nested_form').slideUp().remove()

addRemoveParticipantClickHandler = ->
  $(".remove-participant").click removeParticipant

ready = ->
  disableFullyBookedOptions()

  addRemoveParticipantClickHandler()

  if $('.duplicatable_nested_form').length
    duplicatableForm = $('.duplicatable_nested_form').last()
    nestedForm = duplicatableForm.clone()
    duplicatableForm.remove()

  $('#add-participant-button').click (e) ->
    e.preventDefault()

    lastNestedForm = $('.duplicatable_nested_form').last()
    newNestedForm  = $(nestedForm).clone()
    numberOfParticipants = $('.duplicatable_nested_form').length

    $(newNestedForm).find('label').each ->
      oldLabel = $(this).attr 'for'
      newLabel = oldLabel.replace(new RegExp(/_[0-9]+_/), "_#{numberOfParticipants}_")
      $(this).attr 'for', newLabel

    $(newNestedForm).find('select, input').each ->
      oldId = $(this).attr 'id'
      newId = oldId.replace(new RegExp(/_[0-9]+_/), "_#{numberOfParticipants}_")
      $(this).attr 'id', newId

      oldName = $(this).attr 'name'
      newName = oldName.replace(new RegExp(/\[[0-9]+\]/), "[#{numberOfParticipants}]")
      $(this).attr 'name', newName

    $("#participants").append(newNestedForm)

    $(newNestedForm).find(".registration_participants_name input").focus()

    addRemoveParticipantClickHandler()

$(document).ready(ready)
$(document).on('page:load', ready)
