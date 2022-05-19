class PostMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.reservation_created.subject
  #
  def reservation_created
    @greeting = "Hi"

    mail to: User.email
  end
end
