class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    
    @chat = Chat.new(host_id: current_user.id, amount: 100, is_paid: "0")
    @chat.save
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        languages = params["user"]["teach_languages"]
        if languages.nil?
        else
          @user.teach_languages.destroy_all
          languages.each {|x| @user.teach_languages.create(name: x)} 
        end
        
        languages = params["user"]["learn_languages"]
        if languages.nil?
        else
          @user.learn_languages.destroy_all
          languages.each {|x| @user.learn_languages.create(name: x)} 
        end
        
        interests = params["user"]["interests"]
        if interests.nil?
        else
          @user.interests.destroy_all
          interests.each {|x| @user.interests.create(name: x)} 
        end

        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def host_session
    @opentok= OpenTok::OpenTok.new(ENV["API_KEY"], ENV["API_SECRET"])
    sessionId = @opentok.create_session.session_id
    url = "/vidchat/#{sessionId}"
    redirect_to url
  end


  def join_session
    @opentok= OpenTok::OpenTok.new(ENV["API_KEY"], ENV["API_SECRET"])
    session_id = params[:session_id]
    token = @opentok.generate_token(session_id)
    api_key = ENV["API_KEY"]

    render :video, :locals => {
      :api_key => api_key,
      :session_id => session_id,
      :token => token
    }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      # byebug
      # @languages = Language.all.pluck(:name)

      params.require(:user).permit(:last_name, :first_name, :email, :age, :gender, :learn_language)
    end
end
