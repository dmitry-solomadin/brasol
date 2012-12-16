Spree::BaseHelper.class_eval do
  def ukraine
    Spree::Country.find_by_id(211)
  end

  def get_taxonomies
    @taxonomies ||= Spree::Taxonomy.includes(:root => :children)
  end
end