class NotificationsController < ApplicationController

  # marks a notification as read for this current_user
  def read
    Notification.mark_as_read! :all, :for => current_user
    redirect_to root_url
  end

end
