Spree::CheckoutController.class_eval do

  def update
    if @order.update_attributes(object_params) and @order.errors.empty?
      create_and_associate_user

      if @order.errors.present?
        respond_with(@order) { |format| format.html { render :edit } } and return
      end

      fire_event('spree.checkout.update')
      unless apply_coupon_code
        respond_with(@order) { |format| format.html { render :edit } }
        return
      end

      if @order.next
        state_callback(:after)
      else
        flash[:error] = t(:payment_processing_failed)
        respond_with(@order, :location => checkout_state_path(@order.state))
        return
      end

      if @order.state == 'complete' || @order.completed?
        flash.notice = t(:order_processed_successfully)
        flash[:commerce_tracking] = 'nothing special'
        respond_with(@order, :location => completion_route)
      else
        respond_with(@order, :location => checkout_state_path(@order.state))
      end
    else
      respond_with(@order) { |format| format.html { render :edit } }
    end
  end

  def before_address
    if @order.user
      unless @order.bill_address
        @order.bill_address ||= @order.user.bill_address || Spree::Address.default
      end
      unless @order.ship_address
        @order.ship_address ||= @order.user.ship_address || Spree::Address.default
      end
    else
      @order.bill_address = Spree::Address.default unless @order.ship_address
      @order.ship_address = Spree::Address.default unless @order.ship_address
    end

    if @order.user
      @order.bill_address.firstname = @order.user.firstname if @order.user.firstname.present?
      @order.bill_address.lastname = @order.user.lastname if @order.user.lastname.present?
    end
  end

  def create_and_associate_user
    return if (not @order.state == "address") || current_user

    existing_user = Spree::User.find_by_email(params[:order][:new_user_email])
    if existing_user && existing_user.valid_password?(params[:order][:new_user_password])
      sign_in existing_user
      return
    end

    user = Spree::User.new(email: params[:order][:new_user_email], password: params[:order][:new_user_password],
                           password_confirmation: params[:order][:new_user_password])
    if user.save
      sign_in user
      @order.associate_user! user
    else
      user.errors.each { |key, message| @order.errors.add(key, message) }
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

  def check_registration
    return if session[:seen_reg_page]
    return if spree_current_user or current_order.email
    store_location
    redirect_to spree.checkout_registration_path
  end

end