Deface::Override.new(:virtual_path => 'spree/checkout/_address',
                     :name => 'add_hide_to_country',
                     :set_attributes => 'p#bcountry',
                     :attributes => {class: 'hide'})
Deface::Override.new(:virtual_path => "spree/checkout/_address",
                     :name => "country_ukraine",
                     :replace => "code[erb-loud]:contains(\"bill_form.collection_select :country_id, available_countries, :id, :name, {}, {:class => 'required'}\")",
                     :text => "<%= bill_form.hidden_field :country_id, :value => ukraine.id %>")