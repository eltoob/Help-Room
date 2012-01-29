ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "tutorinstant.com",
  :user_name            => "info@tutorinstant.com",
  :password             => "elietoubi",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
