class StreamsController < ApplicationController

  def host
  	@opentok= OpenTok::OpenTok.new(ENV["API_KEY"], ENV["API_SECRET"])

    @chat = Chat.where(host_id: current_user.id, amount: nil).last
    if @chat.nil?
      @sessionId = @opentok.create_session.session_id
      @new_host = Chat.create(chat_session: @sessionId, host_id: current_user.id)
    else
      @sessionId = @chat.chat_session
    end
    
    url = "/vidchat/" + @sessionId.to_s
    redirect_to url
  end

  def join
  	@opentok= OpenTok::OpenTok.new(ENV["API_KEY"], ENV["API_SECRET"])
    session_id = params[:session_id]
    token = @opentok.generate_token(session_id)
    api_key = ENV["API_KEY"]
    @chat = Chat.find_by(chat_session: params[:session_id])
      if @chat.guest_id.nil?
        @new_guest = @chat
        @new_guest.update(guest_id: current_user.id)
      end
    render :video, :locals => {
      :api_key => api_key,
      :session_id => session_id,
      :token => token
    }
  end
  
end
