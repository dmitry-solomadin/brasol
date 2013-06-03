Spree::Order.class_eval do

  attr_accessible :new_user_email, :new_user_password
  attr_accessor :new_user_email, :new_user_password

  def deliver_order_confirmation_email
    begin
      Spree::OrderMailer.delay.confirm_email(self)
    rescue Exception => e
      logger.error("#{e.class.name}: #{e.message}")
      logger.error(e.backtrace * "\n")
    end
  end

  def new_user_email=(email)
    self.email = email
  end

end