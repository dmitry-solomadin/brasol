$.fn.combinedHover = (settings) ->
  trigger = this
  additionalTriggers = settings.additionalTriggers

  trigger[0].hovercount = 0

  updateHoverCount = (toAdd) -> trigger[0].hovercount = trigger[0].hovercount + toAdd
  addHoverCount = -> updateHoverCount(1)
  removeHoverCount = ->
    updateHoverCount(-1)
    offTrigger = -> settings.offTrigger() if trigger[0].hovercount == 0
    setTimeout offTrigger, 100

  if settings.live
    $(document).on('mouseenter', additionalTriggers, -> addHoverCount())
      .on('mouseleave', additionalTriggers, -> removeHoverCount())
  else
    additionalTriggers.on('mouseenter', -> addHoverCount())
      .on('mouseleave', -> removeHoverCount())

  trigger.on('mouseenter', ->
    addHoverCount()
    settings.onTrigger()
  ).on('mouseleave', -> removeHoverCount())