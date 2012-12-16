$ ->
  class TopMenu

    constructor: ->
      for taxHeader in $(".taxonomy-root-header")
        onTrigger = ((taxHeader)-> -> window.topMenu.showMenu(taxHeader))(taxHeader)
        offTrigger = ((taxHeader)-> -> window.topMenu.hideMenu(taxHeader))(taxHeader)

        $(taxHeader).combinedHover
          additionalTriggers: ".taxonomyContent"
          live: true
          onTrigger: onTrigger
          offTrigger: offTrigger

    showMenu: (header) ->
      taxId = $(header).data("tax-id")
      $("#taxonomyContent#{taxId}").css(
        position: "absolute"
        left: $(header).position().left
        top: $(header).offset().top + 1
      ).show()

    hideMenu: (header) ->
      taxId = $(header).data("tax-id")
      $("#taxonomyContent#{taxId}").hide()

  window.topMenu = new TopMenu()