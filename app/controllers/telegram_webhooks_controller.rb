require 'rest-client'
class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def start(*)
    respond_with :message, text: t('.hi')
    puts from['id']
  end

  def alert(args)
    @server =  Server.find_by(name: args)
    if @server == nil
      puts "wtf"
      begin
      cevap = RestClient.get("https://api.twitch.tv/kraken/channels/#{args}", headers={'Client-ID': 'hndmr9nq1m74r78whfmj3v04m0jvbc'})
      icerik = JSON.parse(cevap)
    rescue RestClient::ExceptionWithResponse => e
      puts e.response
      suitable = false
      end
      puts "lul"
      if icerik == nil
        suitable = false
        respond_with :message, text: "Böyle bir kanal bulunmamaktadır."
      else
      if icerik['followers'] > 10
        suitable = true
      @server = Server.create(name: args)
    else
      suitable = false
      respond_with :message, text: "Eklemek istediğiniz kanalın 10 dan fazla followeri olması gerekmektedir."
    end
  end
    else
      suitable = true
    end
    if suitable == true
    @user = @server.users.find_by(channel_id: from['id'])
    if @user == nil
      @server.users.create(channel_id: from['id'])
      respond_with :message, text: "#{args} #{t('.bildirim_on')}"
    else
      @user.destroy
      respond_with :message, text: "#{args} #{t('.bildirim_off')}"
    end
  end
    # @server.users.create(channel_id: 215682104)
    #respond_with :message, text: t('.bildirim_off')

  end
end
