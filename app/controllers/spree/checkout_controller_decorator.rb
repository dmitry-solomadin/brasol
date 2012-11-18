Spree::CheckoutController.class_eval do
  def before_address
    @order.bill_address ||= @order.user.bill_address || Spree::Address.default
    @order.ship_address ||= @order.user.ship_address || Spree::Address.default

    @order.bill_address.firstname = @order.user.firstname if @order.user.firstname.present?
    @order.bill_address.lastname = @order.user.lastname if @order.user.lastname.present?
  end

  def after_complete
    @order.user.update_attribute(:bill_address, @order.bill_address) # Update last billing address used.
    @order.user.update_attribute(:ship_address, (@order.bill_address == @order.ship_address ? nil : @order.ship_address)) # Update last shipping address used.
    @order.user.update_attribute(:firstname, @order.bill_address.firstname)
    @order.user.update_attribute(:lastname, @order.bill_address.lastname)
    session[:order_id] = nil
  end
end