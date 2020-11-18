class Admin::UsersController < ApiController
  before_action :authenticate_user

  def index
    @following = UserFollow.where(user_id: @current_user.id).pluck(:movie_id)
    @q = Movie.where(id: @following).ransack(params[:q])
    @movies = @q.result.order(name: 'ASC')
  end

  def new
    @user = User.new
  end

  def show
    @following = UserFollow.where(user_id: @current_user.id).pluck(:movie_id)
    @movies = Movie.where(id: @following)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      set_flash_notification :success, :create, entity: 'User'
      redirect_to admin_users_path
    else
      set_instant_flash_notification :danger, :default, {:message => @user.errors.messages[:base][0]}
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    @user.attributes = user_params
    if @user.important_changed?
    end
    if @user.save
      set_flash_notification :success, :update, entity: 'User'
      redirect_to admin_users_path
    else
      set_instant_flash_notification :danger, :default, {:message => @user.errors.messages[:base][0]}
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :phone_number, :password)
  end


  def checks_for_logged_in_user
    unless user_signed_in?
      protocol = Rails.application.routes.default_url_options[:protocol] || "http"
      redirect_to new_user_session_url(protocol: protocol)
    end
  end
end
