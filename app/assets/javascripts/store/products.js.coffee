$ ->
  $('#add-to-cart-button').popover
    animation: true
    placement: "top"
    trigger: "manual"

  $(document).on 'click', (e) ->
    if $('.cart-popover:visible')[0] and e.target.id isnt 'add-to-cart-button'
      $('#add-to-cart-button').popover('hide')
      $(".cart-popover").animate(top: $(".cart-popover").offset().top - 10, 'fast')

  $("#cart-form").on "submit", ->
    if $("#sizeSelect")[0] or $("#colorSelect")[0]
      sizeMissing = ` $("#sizeSelect option:selected").val() == -1 `
      colorMissing = ` $("#colorSelect option:selected").val() == -1 `
      if sizeMissing or colorMissing
        if sizeMissing and colorMissing
          popoverContent = "Выберете размер и цвет"
        else if sizeMissing
          popoverContent = "Выберете размер"
        else if colorMissing
          popoverContent = "Выберете цвет"

        $('#add-to-cart-button').data("class", "cart-popover")
        $('#add-to-cart-button').data("offset-height", "25")
        $('#add-to-cart-button').attr("data-content", popoverContent)
        $('#add-to-cart-button').popover('show')
        $(".cart-popover").animate(top: $(".cart-popover").offset().top + 10, 'fast')

        return false

      $('#add-to-cart-button').popover('hide')
      return true

    $('#add-to-cart-button').popover('hide')
    return true

  selectProperVariant = ->
    size = $("#sizeSelect option:selected").val()
    color = $("#colorSelect option:selected").val()
    if size and color
      variantString = "#variant#{size}_#{color}"
    else if size
      variantString = "#variant#{size}"
    else if color
      variantString = "#variant#{color}"

    variantId = $(variantString).val()
    $("#variantsSelect option[value='#{variantId}']").attr("selected", "selected")

  $("#sizeSelect").on 'change', -> selectProperVariant()
  $("#colorSelect").on 'change', -> selectProperVariant()