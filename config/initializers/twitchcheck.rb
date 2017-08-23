require "rest-client"
require "json"
require 'telegram/bot'
puts "Sunucular aktifleştiriliyor"
thr = Thread.new do
    fakequeue = 0
    @online = {}
    @online.default = 0
  loop do
    @servers = Server.all
    @servers.each do |s|
    cevap = RestClient.get("https://api.twitch.tv/kraken/streams/#{s.name}", headers={'Client-ID': 'hndmr9nq1m74r78whfmj3v04m0jvbc'})
    icerik = JSON.parse(cevap)
    if icerik['stream'] != nil
      @online[s.name] += 1
      if @online[s.name] == 1
        s.users.all.each do |user|
          Telegram.bot.send_message chat_id: user.channel_id, text: "#{s.name} yayın açtı."
        end
      end
    else
      @online[s.name] = 0
    end
  end
    sleep(10)
  end
end
