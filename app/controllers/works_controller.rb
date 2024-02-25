class WorksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :index]
  before_action :correct_user,   only: :destroy
  before_action :admin_user, only: [:index]
  

  def create
    @work = current_user.works.build(work_params)
    if @work.save
      flash[:success] = "出勤記録が登録されました"
      redirect_to user_path(current_user)
    else

      render 'top_pages/home', status: :unprocessable_entity
    end
  end


  def destroy
  end

  def index
    @selected_year = params[:year] || Date.today.year
    @selected_month = params[:month] || Date.today.month
    @selected_day = params[:day] || Date.today.day
    if @selected_month.class != Integer
      if @selected_month.to_i < 10
        @selected_month = "0" + @selected_month 
      end
    else
      if @selected_month < 10
        @selected_month = '0' + @selected_month.to_s
      else
        @selected_month = @selected_month.to_s
      end
    end

    if @selected_year.class == Integer
      @selected_year = @selected_year.to_s
    end

    if @selected_day.class != Integer
      if @selected_day.to_i < 10
        @selected_day = "0" + @selected_day
      end
    else
      if @selected_day < 10
        @selected_day = '0' + @selected_day.to_s
      else
        @selected_day = @selected_day.to_s
      end
    end
    if !params[:department].present?
      @works = Work.where("strftime('%Y', date) = ? AND strftime('%m', date)  = ? AND strftime('%d',date) = ?" , @selected_year, @selected_month, @selected_day)
    else
      @works = Work.joins(:user).where("strftime('%Y', date) = ? AND strftime('%m', date) = ? AND strftime('%d', date) = ? AND department = ?", @selected_year, @selected_month, @selected_day, params[:department])
    end
    @works = @works.paginate(page: params[:page])
  end

  private

    def work_params
      params.require(:work).permit(:date, :comment, :start_time, :end_time, :break_time)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @micropost.nil?
    end

    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end

end
