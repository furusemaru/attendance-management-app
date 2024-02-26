class WorksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :edit, :index, :update]
  before_action :correct_user,   only: [:destroy, :edit, :update]
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

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      flash[:success] = "勤務記録が更新されました"
      redirect_to @work.user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @works.destroy
    flash[:success] = "勤怠記録を削除しました。"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
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
      params.require(:work).permit(:date, :comment, :start_time, :end_time, :break_time, :location)
    end

    def correct_user
      @works = current_user.works.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @works.nil?
    end

    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end

end
