Spree::Order.class_eval do

  def deliver_order_confirmation_email
    begin
      Spree::OrderMailer.delay.confirm_email(self)
    rescue Exception => e
      logger.error("#{e.class.name}: #{e.message}")
      logger.error(e.backtrace * "\n")
    end
  end

end