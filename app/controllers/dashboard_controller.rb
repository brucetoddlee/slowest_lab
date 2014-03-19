class DashboardController < ApplicationController
  def show
    if !signed_in?
      redirect_to new_session_path
    else
      @attendances = current_user.attendances.includes(:show => :venue)

      # # This is the worst:
      # @followed_attendances = []
      # current_user.followeds.map{|u| u.attendances}.each do |a|
      #   @followed_attendances += a
      # end

      @followed_attendances = Attendance.includes(
        :user, :show => :venue
        ).joins(:user => :inward_follows
        ).where(:follows => {:follower_id => current_user.id}
        ).order('shows.date asc').limit(300)

      # @followed_attendances.sort_by!{|a| a.show.date}
      
    end
  end
end