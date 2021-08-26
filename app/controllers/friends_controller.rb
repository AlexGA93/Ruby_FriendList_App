class FriendsController < ApplicationController
  before_action :set_friend, only: [ :show,  :edit, :update, :destroy ]

  # 'If a user is not authenticated don't let it do anything except controller methods'
  before_action :authenticate_user!, except: [:index, :show]

  # check if the curent user is the correct one
  before_action :correct_user, only: [:edit, :update, :destroy]


  # GET /friends or /friends.json
  def index
    @friends = Friend.all
  end 

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  # we want to associate tis friend with the user who is creating it.
  def new
    # @friend = Friend.new
    @friend = current_user.friends.build
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  # we want to associate tis friend with the user who is creating it.
  def create
    # @friend = Friend.new(friend_params)
    @friend = current_user.friends.build(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /friends/1 or /friends/1.json
  def destroy
    respond_to do |format|
      if @friend.destroy()
        format.html { redirect_to friends_url, notice: "Friend was successfully destroyed without mercy." }
        format.json { head :no_content }
      else
        format.html { redirect_to beverages_url, :alert => "An Error Occurred!"}
        format.json { head :ok }
      end
    end
  end

  def correct_user
    # The correct user is the one who's been associated with this id
    @friend = current_user.friends.find_by(id: params[:id])
    # If is not the correct user, show a notice message and redirect
    redirect_to friends_path, notice: "Not Autherized to Edit this Friend" if @friend.nil?
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter,:user_id)
    end
end
