require 'RMagick'
require 'dotenv/load'
require 'twilio-ruby'
require 'imgur'

ACCOUNT_SID = ENV['TWILIO_SID'].freeze
AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN'].freeze

module Notification
  IMAGE_PATH = './updates.png'.freeze

  def self.mms(players)
    players.map! { |player| "#{player[:name]} (#{player[:team]}) now costs #{player[:salary]}" }
    generate_image(players)

    client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    client.messages.create(
      from: '+13858316089',
      to: '+393669785418',
      body: 'Your DFS price updates are in!',
      media_url: upload_image
    )
  end

  def self.generate_image(infos)
    canvas = Magick::Image.new(480, 60 + infos.count * 30) {self.background_color = 'white'}
    gc = Magick::Draw.new
    gc.pointsize(20) # Sets the fontsize

    infos.each_with_index do |info, index|
      gc.text(10, 60 + index * 30, info.center(11))
    end

    gc.draw(canvas)
    canvas.write(IMAGE_PATH)
  end

  def self.upload_image
    client = Imgur.new(ENV['IMGUR_CLIENT_KEY'])
    image = Imgur::LocalImage.new(IMAGE_PATH, title: 'My DFS update')
    up = client.upload(image)
    puts up.link
    up.link
  end
end
