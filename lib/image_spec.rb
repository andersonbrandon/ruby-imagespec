require 'parsers/jpeg'
require 'parsers/png'
require 'parsers/gif'
require 'parsers/swf'

module ImageSpec
  
  class Dimensions
    attr_reader :width, :height
    
    def initialize(file)
      # Depending on the type of our file, parse accordingly
      case File.extname(file)
        when ".swf"
          @width, @height = SWF.dimensions(file)
        when ".jpg", ".jpeg"
          @width, @height = JPEG.dimensions(file)
        when ".gif"
          @width, @height = GIF.dimensions(file)
        when ".png"
          @width, @height = PNG.dimensions(file)
        else
          raise "Unsupported file type. Sorry bub :("
      end
    end
    
  end
  
end