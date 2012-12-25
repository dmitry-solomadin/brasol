Deface::Override.new(:virtual_path => "spree/shared/_products",
                     :name => "small_to_smaller_image_products",
                     :replace => "code[erb-loud]:contains(\"link_to small_image(product, :itemprop => 'image'), product, :itemprop => 'url'\")",
                     :text => "<%= link_to smaller_image(product, :itemprop => 'image'), product, :itemprop => 'url' %>")

Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                     :name => "small_to_smaller_image_order_details",
                     :replace => "code[erb-loud]:contains('link_to small_image(item.variant.product), item.variant.product')",
                     :text => "<%= link_to smaller_image(item.variant.product), item.variant.product %>")

Deface::Override.new(:virtual_path => "spree/orders/_line_item",
                     :name => "small_to_smaller_image_line_item",
                     :replace => "code[erb-loud]:contains('link_to small_image(variant.product), variant.product')",
                     :text => "<%= link_to smaller_image(variant.product), variant.product %>")

