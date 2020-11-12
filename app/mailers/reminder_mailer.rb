class ReminderMailer < ApplicationMailer

    default :from => "ryan@railscasts.com"
  
  def movie_reminder(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Movie Reminder")
  end

end
