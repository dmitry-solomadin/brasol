Spree::OrderMailer.class_eval do

  def confirm_email(order, resend = false)
    @order = order
    subject = (resend ? "[#{t(:resend).upcase}] " : '')
    subject += "#{Spree::Config[:site_name]} #{t('order_mailer.confirm_email.subject')} ##{order.number}"
    mail(:to => order.email,
         :bcc => "brasolfashion@gmail.com",
         :subject => subject)
  end

end

