class Admin::MoviesController < ApiController
    before_action :authenticate_user
    def index
        @movies = Movie.all
        @following = UserFollow.where(user_id: @current_user.id).pluck(:movie_id)
    end

    def follow
        follow = UserFollow.where(user_id: @current_user.id, movie_id: params[:movie_id])
        @follow = UserFollow.new(user_id: @current_user.id, movie_id: params[:movie_id])
        if @follow.save
          ReminderMailer.movie_reminder(@current_user).deliver
          set_flash_notification :success, :create, entity: 'Followed'
        else
          set_instant_flash_notification :danger, :default, {:message => @follow.errors.messages[:base][0]}
        end
        redirect_to admin_movies_path
      end

end