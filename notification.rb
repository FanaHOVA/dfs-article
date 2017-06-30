require 'RMagick'

module Notification
  def self.mms(player)
    info = "#{player[:name]} (#{player[:team]}) now costs #{player[:salary]}"
    generate_image(info)

  end

  def self.generate_image(info)
    canvas = Magick::Image.new(480, 700) {self.background_color = 'yellow'}
    gc = Magick::Draw.new
    gc.pointsize(20)
    title = 'New DFS updates:'
    gc.text(10, 30, title.center(11))
    gc.text(10, 60, info.center(11))

    gc.draw(canvas)
    canvas.write('./image.png')
  end
end
