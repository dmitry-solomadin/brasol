Deface::Override.new(:virtual_path => "spree/users/edit",
                     :name => "add_user_additional_form",
                     :insert_after => "code[erb-loud]:contains(\"render :partial => 'spree/shared/user_form', :locals => { :f => f }\")",
                     :text => "<%= render :partial => 'spree/shared/user_additional_form', :locals => { :f => f } %>")

