thr = Thread.new do
  loop do
    @server = Server.all
    @server.each do |a|
    cevap = RestClient.get('https://api.twitch.tv/kraken/streams/' +, headers={'Client-ID': 'hndmr9nq1m74r78whfmj3v04m0jvbc'})
    icerik = JSON.parse(cevap)
    if icerik['stream'] != nil
      onlinecount += 1
    else
      onlinecount = 0
    end
    sleep(300)
  end
end

Thread.new do
  loop do
    if onlinecount == 1
      dosya = File.read('kisiler.json')
      kisiler = JSON.parse(dosya)
      kisiler['videoyun'].each do |kisi|
        channel = TelegramBot::Channel.new(id: kisi)
        o = TelegramBot::OutMessage.new
        o.chat = channel
        o.text = "Videoyun yayın açtı."
        o.send_with(bot)
      end
      onlinecount += 1
    end
    sleep(60)
  end
end
