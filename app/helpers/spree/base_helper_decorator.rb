Spree::BaseHelper.class_eval do
  def ukraine
    Spree::Country.find_by_id(211)
  end

  def get_taxonomies
    @taxonomies ||= Spree::Taxonomy.includes(:root => :children)
  end

  def bottom_level_taxons(root_taxon)
    return [root_taxon] if root_taxon.children.empty?
    root_taxon.children.map do |taxon|
      bottom_level_taxons(taxon)
    end.flatten
  end

  # from spree_minicart
  # removed current_page? check because link_to_cart is called everywhere by spree_minicart
  def link_to_cart(text = nil)
    text = text ? h(text) : t('cart')
    css_class = nil

    if current_order.nil? or current_order.line_items.empty?
      text = "#{text}: (#{t('empty')})"
      css_class = 'empty'
    else
      text = "#{text}: (#{current_order.item_count})  <span class='amount'>#{current_order.display_total}</span>".html_safe
      css_class = 'full'
    end

    link_to text, cart_path, :class => css_class
  end
end