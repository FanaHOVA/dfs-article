require 'RMagick'

module Notification
  def self.mms(players)
    players.map! { |player| "#{player[:name]} (#{player[:team]}) now costs #{player[:salary]}" }
    puts players
    generate_image(players)

  end

  def self.generate_image(infos)
    canvas = Magick::Image.new(480, 700) {self.background_color = 'white'}
    gc = Magick::Draw.new
    gc.pointsize(20)
    title = 'New DFS updates:'
    gc.text(10, 30, title.center(11))

    infos.each do |info|
      gc.text(10, 60, info.center(11))
      gc.draw(canvas)
    end

    canvas.write('./image.png')
  end
end
