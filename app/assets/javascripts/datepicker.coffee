$(document).on 'turbolinks:load', ->
  $('.datepicker').pickadate ->
    selectMonths: true,
    selectYears: 5,
    today: 'Today',
    clear: 'Clear',
    close: 'Ok',
    closeOnSelect: true,
    format: 'dd/mm/yyyy'
  return
