class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def start(*)
    respond_with :message, text: t('.hi')
    puts from['id']
  end

  def alert(args)
    @server =  Server.find_by(name: args)
    if @server == nil
      @server = Server.create(name: args)
    else
    end
    @user = @server.users.find_by(channel_id: from['id'])
    if @user == nil
      @server.users.create(channel_id: from['id'])
      respond_with :message, text: "#{args} #{t('.bildirim_on')}"
    else
      @user.destroy
      respond_with :message, text: "#{args} #{t('.bildirim_off')}"
    end

    # @server.users.create(channel_id: 215682104)
    #respond_with :message, text: t('.bildirim_off')

  end
end
