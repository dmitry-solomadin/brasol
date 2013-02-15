Deface::Override.new(:virtual_path => 'spree/shared/_main_nav_bar',
                     :name => 'add_mini_cart',
                     :insert_bottom => "#link-to-cart",
                     :partial => "spree/shared/minicart")

# insert loading message
Deface::Override.new(:virtual_path => 'spree/layouts/spree_application',
                     :name => 'append_loading_message',
                     :insert_top => "#wrapper",
                     :text => %q{<div id="progress"><%= image_tag 'admin/progress.gif' %> <%= t(:loading) %>...</div>})


