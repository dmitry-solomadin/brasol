Spree::CheckoutController.class_eval do
  def before_address
    if @order.user
      @order.bill_address ||= @order.user.bill_address || Spree::Address.default
      @order.ship_address ||= @order.user.ship_address || Spree::Address.default
    else
      @order.bill_address = Spree::Address.default
      @order.ship_address = Spree::Address.default
    end

    if @order.user
      @order.bill_address.firstname = @order.user.firstname if @order.user.firstname.present?
      @order.bill_address.lastname = @order.user.lastname if @order.user.lastname.present?
    end
  end

  def after_complete
    if @order.user
      @order.user.update_attribute(:bill_address, @order.bill_address) # Update last billing address used.
      @order.user.update_attribute(:ship_address, (@order.bill_address == @order.ship_address ? nil : @order.ship_address)) # Update last shipping address used.
      @order.user.update_attribute(:firstname, @order.bill_address.firstname)
      @order.user.update_attribute(:lastname, @order.bill_address.lastname)
    end

    session[:order_id] = nil
  end
end