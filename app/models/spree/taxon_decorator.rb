Spree::Taxon.class_eval do

  def applicable_filters
    fs = []
    fs << Spree::ProductFilters.taxons_below(self)
    ## unless it's a root taxon? left open for demo purposes

    fs << Spree::ProductFilters.price_filter if Spree::ProductFilters.respond_to?(:price_filter)
    fs << Spree::ProductFilters.brand_filter if Spree::ProductFilters.respond_to?(:brand_filter)
    fs
  end

end