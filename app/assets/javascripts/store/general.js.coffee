$(document).bind 'ajaxSend', (e, request, options) ->
  $('[data-loading]').each ->
    $(@).attr("disabled","disabled")
    $(@).data("prevText", $(@).html())
    $(@).html($(@).data("loading"))

$(document).bind 'ajaxComplete', (e, request, options) ->
  $('[data-loading]').each ->
    $(@).removeAttr("disabled")
    $(@).html($(@).data("prevText"))
