#= require store/spree_core
#= require store/jquery.hoverIntent

$ ->
  config =
    over: ->
      $("#minicart").slideDown('fast') if $("#minicart").children().length > 0
    timeout: 250
    out: -> $("#minicart").slideUp('fast')

  $("#link-to-cart").hoverIntent(config)

  $("#minicart-actions .delete img").click (e) ->
    $(this).parents('form').first().find(".line_item_quantity").val("0")
    $(this).parents('form').first().submit()
    e.preventDefault()



