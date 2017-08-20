# require "rest-client"
# require "json"
# puts "Sunucular aktifleştiriliyor"
# thr = Thread.new do
#   loop do
#     online = {}
#     online.default = 0
#     @server = Server.all
#     puts @server
#     @server.each do |a|
#       cevap = RestClient.get("https://api.twitch.tv/kraken/streams/#{a.name}", headers={'Client-ID': 'hndmr9nq1m74r78whfmj3v04m0jvbc'})
#       puts "Parsing"
#       icerik = JSON.parse(cevap)
#       puts online
#       if icerik['stream'] != nil
#         online[a.name] += 1
#       else
#         online[a.name] = 0
#       end
#     end
#     sleep(10)
#
#   end
# end
# puts "Second Thread starting"
# Thread.new do
#   loop do
#     puts "Basliyo loop"
#     online.each do |server, status|
#       puts status
#       if status == 1
#         Server.find_by(name: server).users.all.each do |user|
#           bot.send_message chat_id: user.channel_id, text: "#{server} yayın açtı."
#           puts "Yayın açtı alert"
#
#         end
#       end
#     end
#     sleep(2)
#   end
# end
