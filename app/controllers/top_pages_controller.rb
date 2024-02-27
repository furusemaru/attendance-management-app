class TopPagesController < ApplicationController
  def home
    if logged_in?
      @work = current_user.works.build 
      if current_user.admin?
        @users = User.all.select { |user| user.overtime_this_month > 126000 }
        @users = User.where(id: @users.map(&:id)).paginate(page: params[:page])
        @this_month = Date.today.month < 10 ? '0' + Date.today.month.to_s : Date.today.month.to_s 
        @this_year = Date.today.year.to_s
      end
    end
  end
end
