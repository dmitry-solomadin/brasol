Spree::UserRegistrationsController.class_eval do

  def seen_reg_page
    session[:seen_reg_page] = true
    redirect_to checkout_state_path("address")
  end

end