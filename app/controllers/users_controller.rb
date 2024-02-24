class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :index]
  before_action :correct_user,   only: [:edit, :update, :show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @selected_year = params[:year] || Date.today.year
    @selected_month = params[:month] || Date.today.month
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
    
    # 選択された年月に基づいてデータを取得
    @works = @user.works.where("strftime('%Y', date) = ? AND strftime('%m', date)  = ?", @selected_year, @selected_month)
    
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = 'ログインに成功しました'
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_cofirmation)
    end


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end
end
