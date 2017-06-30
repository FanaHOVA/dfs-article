require 'RMagick'

module Notification
  def self.mms(players)
    players.map! { |player| "#{player[:name]} (#{player[:team]}) now costs #{player[:salary]}" }
    generate_image(players)
  end

  def self.generate_image(infos)
    title = 'New DFS prices:'

    canvas = Magick::Image.new(480, 60 + infos.count * 30) {self.background_color = 'white'}
    gc = Magick::Draw.new
    gc.pointsize(20) # Sets the fontsize
    gc.text(10, 30, title.center(11)) # Sets x,y position in the canvas

    infos.each_with_index do |info, index|
      gc.text(10, 60 + index * 30, info.center(11))
    end

    gc.draw(canvas)
    canvas.write('./updates.png')
  end
end
