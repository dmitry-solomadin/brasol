Deface::Override.new(:virtual_path => "spree/checkout/_address",
                     :name => "shipping_address_remove",
                     :remove => "[data-hook='shipping_fieldset_wrapper']")
Deface::Override.new(:virtual_path => "spree/checkout/_address",
                     :name => "shipping_address_checkbox",
                     :insert_before => "#billing",
                     :text => "<input id='order_use_billing' style='display:none' name='order[use_billing]' type='checkbox' value='1' checked='checked'>")
Deface::Override.new(:virtual_path => "spree/checkout/_address",
                     :name => "billing_address_header",
                     :replace => "code[erb-loud]:contains('t(:billing_address)')",
                     :text => "<%= t(:billing_address_new) %>")


