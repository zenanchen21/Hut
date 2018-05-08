# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

isOn = 'block'
$('#cons').change ->
  isOn = if isOn == 'none' then 'block' else 'none'
  $('#exp').css 'display', isOn
  return
