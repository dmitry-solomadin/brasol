module Spree
  class HomeController < Spree::StoreController
    helper 'spree/products'
    respond_to :html

    def index
      @products = {}

      Spree::Taxonomy.includes(:root => :children).each do |taxonomy|
        view_context.bottom_level_taxons(taxonomy.root).each do |t|
          base_scope = Spree::Product.active
          base_scope = base_scope.in_taxon(t)
          base_scope = base_scope.on_hand unless Spree::Config[:show_zero_stock_products]
          @products[t] = base_scope.includes([:master => :prices]).limit(4)
        end
      end
    end

  end
end
