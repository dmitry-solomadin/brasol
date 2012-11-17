Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "ajaxify_add_to_cart_links",
                     :replace => "code[erb-loud]:contains('form_for :order, :url => populate_orders_url do |f|')",
                     :text => "<%= form_for :order, :url => populate_orders_url, :remote => true do |f| %>")
