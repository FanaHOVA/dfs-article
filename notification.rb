require 'RMagick'

module Notification
  def self.mms(player)
    generate_image(player)

  end

  def self.generate_image(player)
    canvas = Magick::Image.new(480, 700) {self.background_color = 'yellow'}
    gc = Magick::Draw.new
    gc.pointsize(15)
    gc.text(10,70, player[:name].center(11))
    gc.text(10,120, player[:team].center(11))
    gc.text(10,150, player[:salary].center(11))

    gc.draw(canvas)
    canvas.write('./image.png')
  end
end
