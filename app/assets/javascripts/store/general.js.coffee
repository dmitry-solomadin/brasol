$(document).bind 'ajaxSend', (e, request, options) ->
  $('[data-loading]').each ->
    $(@).attr("disabled","disabled")
    $(@).data("prevText", $(@).html())
    $(@).html($(@).data("loading"))

$(document).bind 'ajaxComplete', (e, request, options) ->
  $('[data-loading]').each ->
    $(@).removeAttr("disabled")
    $(@).html($(@).data("prevText"))


$ ->
  $('#password-showable-wrap :password').showPassword
    linkClass: 'show-password-link'
    linkText: 'Показать'
    showPasswordLinkText: 'Спрятать'
    showPasswordInputClass: 'password-showing'
    linkRightOffset: 0
    linkTopOffset: 0
