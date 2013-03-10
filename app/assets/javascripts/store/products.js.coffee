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
          popoverContent = "Выберите размер и цвет"
        else if sizeMissing
          popoverContent = "Выберите размер"
        else if colorMissing
          popoverContent = "Выберите цвет"

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

  hasVariant = (variantIds, id) -> return true for variantId in variantIds when parseInt(variantId) is parseInt(id)

  filterVariants = (vnameToFilter, vid) ->
    availableVariants = $("[data-#{vnameToFilter}-id='#{vid}']")
    vnameIds = {}
    for availableVariant in availableVariants
      for dataName of $(availableVariant).data()
        continue if dataName is "#{vnameToFilter}Id"
        dataNameTrunc = dataName[0...dataName.length - 2]
        vnameIds[dataNameTrunc] = [] unless vnameIds[dataNameTrunc]
        vnameIds[dataNameTrunc].push $(availableVariant).data()[dataName]

    for vname of vnameIds
      variants = vnameIds[vname]
      for option in $("##{vname}Select > option")
        #continue if parseInt($(option).val()) is -1
        if hasVariant(variants, $(option).val())
          $(option).removeAttr("disabled")
        else
          $(option).attr("disabled", "disabled")

  selectProperVariant = ->
    size = $("#sizeSelect option:selected").val()
    color = $("#colorSelect option:selected").val()

    if $("#sizeSelect")[0] and $("#colorSelect")[0]
      filterVariants("size", size) if size
      filterVariants("color", color) if color

    if size and color
      variantString = "#variant#{size}_#{color}"
    else if size
      variantString = "#variant#{size}"
    else if color
      variantString = "#variant#{color}"

    variantId = $(variantString).val()
    $("#variantsSelect option").removeAttr("selected")
    $("#variantsSelect option[value='#{variantId}']").attr("selected", "selected")
    $("#variantsSelect").val(variantId)

  $("#sizeSelect").on 'change', -> selectProperVariant()
  $("#colorSelect").on 'change', -> selectProperVariant()