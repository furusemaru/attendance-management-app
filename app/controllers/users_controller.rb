class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :index, :destroy, :new, :create]
  before_action :correct_user,   only: []
  before_action :admin_user, only: [:destroy, :index, :new, :create]
  before_action :correct_admin_user, only: [:show, :edit, :update]

  
  def new
    @user = User.new
  end

  
  def show
    @user = User.find(params[:id])
    if @user.admin?
      redirect_to root_url
    end
    @selected_year = params[:year] || Date.today.year.to_s
    @selected_month = params[:month] || Date.today.month.to_s

    # 1~9月の場合
    if @selected_month.to_i < 10
      @selected_month = "0" + @selected_month 
    end
    
    
    
    # 選択された年月に基づいてデータを取得
    @works = @user.works.where("strftime('%Y', date) = ? AND strftime('%m', date)  = ?", @selected_year, @selected_month)
    @total_working_hours = @user.total_working_hours(@selected_month, @selected_year)
    @total_overtime_hours = @user.total_overtime_hours(@selected_month, @selected_year)
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '作成に成功しました'
      redirect_to users_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_edit_params)
      flash[:success] = "変更が適用されました"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def index
    @users = User.all

    @users = @users.where(department: params[:department]) if params[:department].present?

    @users = @users.where("last_name LIKE ?", "%#{params[:last_name]}%") if params[:last_name].present?

    @users = @users.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除に成功しました"
    redirect_to users_url, status: :see_other
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :department, :email, :password, :password_cofirmation)
    end

    def user_edit_params
      if current_user.admin?
        params.require(:user).permit(:first_name, :last_name, :department, :email, :password, :password_confirmation)
      else
        params.require(:user).permit(:password, :password_confirmation)
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end

    def correct_admin_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless ( current_user?(@user) || current_user.admin? )
    end
end
