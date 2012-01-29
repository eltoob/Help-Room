class DeviseMailer < Devise::Mailer
  layout 'email'
  default from: I18n.t("mailer.default.from")
end
