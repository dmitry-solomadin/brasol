Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "submit",
                     :replace => "code[erb-loud]:contains(\"button_tag :class => 'large primary', :id => 'add-to-cart-button', :type => :submit do\")",
                     :text => "<%= button_tag :class => 'large primary', 'data-loading' => t(:adding_to_cart), :id => 'add-to-cart-button', :type => :submit do %>")
