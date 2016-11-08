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
    @user = current_user

    @user_interests = current_user.interests.all

    @user_teach_languages = current_user.teach_languages

    @user_learn_languages = current_user.learn_languages

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if current_user.nil?
      redirect_to root_url
    else
     render :edit
    end
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

        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def preference
    languages = Language.all
    @user = current_user
        languages_t = params["user"]["teach_languages"]

        if languages_t.nil?
        else

              if TeachLanguage.find_by(name: languages_t).nil?
              TeachLanguage.create(name: languages_t)
              end
              a = TeachLanguage.find_by(name: languages_t) 
              a.users << @user
        end

        languages_l = params["user"]["learn_languages"]
        if languages_l.nil?
        else
          
              if LearnLanguage.find_by(name: languages_l).nil?
              LearnLanguage.create(name: languages_l)
              end
              a = LearnLanguage.find_by(name: languages_l) 
              a.users << @user
         end 


        interests = params["user"]["interests"]
        if interests.nil?
        else
          
              if Interest.find_by(name: interests).nil?
              Interest.create(name: interests)
              end
              a = Interest.find_by(name: interests) 
              a.users << @user
        end
       
       redirect_to @user, notice: 'User was successfully updated.'
    
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
      # @languages = Language.all.pluck(:name)
      params.require(:user).permit(:last_name, :first_name, :email, :age, :gender, {avatars: []}, :learn_language)
    end
end
