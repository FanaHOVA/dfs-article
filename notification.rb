require 'RMagick'

module Notification
  def self.mms(player)
    canvas = Magick::Image.new(480, 700) {self.background_color = 'yellow'}
    gc = Magick::Draw.new
    gc.pointsize(50)
    gc.text(10,70, player[:name].center(11))
    gc.text(10,120, player[:team].center(11))
    gc.text(10,150, player[:salary].center(11))

    gc.draw(canvas)
    canvas.write('tst.png')
  end
end
