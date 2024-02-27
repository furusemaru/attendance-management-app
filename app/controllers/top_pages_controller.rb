class TopPagesController < ApplicationController
  def home
    @work = current_user.works.build if logged_in?
    if logged_in? && current_user.admin?
      @users = User.all.select { |user| user.overtime_this_month > 72000 }
      @users = User.where(id: @users.map(&:id)).paginate(page: params[:page])
      @this_month = Date.today.month
      @this_month = @this_month < 10 ? '0' + @this_month.to_s : @this_month.to_s 
      @this_year = Date.today.year.to_s
    end
  end
end
