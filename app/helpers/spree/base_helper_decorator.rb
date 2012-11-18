Spree::BaseHelper.class_eval do
  def ukraine
    Spree::Country.find_by_id(211)
  end
end