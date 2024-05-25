class CheckCurrentUserJob < ApplicationJob
  queue_as :default

  def perform(uid)
    @current_user ||= uid && User.find_by(id: uid)
    @current_user
  end

  
end
