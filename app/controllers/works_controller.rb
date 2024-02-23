class WorksController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]

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

  private

    def work_params
      params.require(:work).permit(:date, :comment, :start_time, :end_time)
    end

end
