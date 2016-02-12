class ApplicationMailer < ActionMailer::Base

  default from: "event-reporter@populusdatasolutions.com"
  layout 'mailer'

  def all_emails
    emails = []

    User.all.each do |user|
      if user.email.present?
        emails.push(user.email)
      end    
    end 

    emails
  end

end
