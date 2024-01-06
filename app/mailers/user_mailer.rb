class UserMailer < ApplicationMailer
    default from: 'yourbookrequests@gmail.com'
    def checkout_email(user,book)
        @user = user
        @book = book
        mail(to: @user.email, subject: 'Your Library Notifications')
    end
  
    def bookmark_email(user,book)
      @user = user
      @book = book
      mail(to: @user.email, subject: 'Your Library Notifications')
    end
  
    def returnbook_email(user,book)
      @user = user
      @book = book
      mail(to: @user.email, subject: 'Your Library Notifications')
    end
  end
  