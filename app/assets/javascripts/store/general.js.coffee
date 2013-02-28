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
  $("#facebook-social").on "mouseover", -> $(@).attr("src", "/assets/store/facebook.png")
  $("#facebook-social").on "mouseout", -> $(@).attr("src", "/assets/store/facebook-bw.png")
  $("#vkontakte-social").on "mouseover", -> $(@).attr("src", "/assets/store/vkontakte.png")
  $("#vkontakte-social").on "mouseout", -> $(@).attr("src", "/assets/store/vkontakte-bw.png")

  $('#password-showable-wrap :password').showPassword
    linkClass: 'show-password-link'
    linkText: 'Показать'
    showPasswordLinkText: 'Спрятать'
    showPasswordInputClass: 'password-showing'
    linkRightOffset: 0
    linkTopOffset: 0
