require "rest-client"
require "json"
require 'telegram/bot'
puts "Sunucular aktifleştiriliyor"

@online = {}
@online.default = 0
thr = Thread.new do
  loop do
    @servers = Server.all.to_a
    alert
    sleep(20)
  end
end
Thread.abort_on_exception = true
#cakma queue deneme 1
def alert
  threads = []
  if @servers.length > 3
    max = 4
  else
    max = @servers.length
  end
  max.times do
    threads <<  Thread.new do
      puts "hi"
      server = @servers.pop
      cevap = RestClient.get("https://api.twitch.tv/kraken/streams/#{server.name}", headers={'Client-ID': 'hndmr9nq1m74r78whfmj3v04m0jvbc'})
      icerik = JSON.parse(cevap)
      if icerik['stream'] != nil
        @online[server.name] += 1
        if @online[server.name] == 1
          server.users.all.each do |user|
            Telegram.bot.send_message chat_id: user.channel_id, text: "#{server.name} yayın açtı."
          end # each
        end # if online
      else
        @online[server.name] = 0
      end #if icerik
    end # thread
end # times
threads.each { |thrd| thrd.join  }
      if @servers != []
    alert
      end
end # def
