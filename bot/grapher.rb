require 'gruff'
module Grapher
  class Grapher 
    attr :path
    def initialize(args)
      g = Gruff::Bar.new
      g.title = "#{args[:title]}"
     
      g.theme = Gruff::Themes::KEYNOTE
      g.data(:CPU, args[:cpu])
      g.data(:RAM, args[:ram])
      g.data(:DISK, args[:disk])
      g.minimum_value = 0
      g.maximum_value = 100
      @path = "#{Dir.pwd}/tmp/#{Time.now.to_i}.png"
      g.write(@path)
    end
  end
end