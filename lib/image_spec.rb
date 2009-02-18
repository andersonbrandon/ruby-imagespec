require File.join(File.dirname(__FILE__), 'parsers', 'jpeg')
require File.join(File.dirname(__FILE__), 'parsers', 'png')
require File.join(File.dirname(__FILE__), 'parsers', 'gif')
require File.join(File.dirname(__FILE__), 'parsers', 'swf')

module ImageSpec

  class Dimensions

    attr_reader :width, :height

    def initialize(file, content_type = nil)
      stream = get_stream(file)
      content_type = content_type(stream) if content_type.nil?

      @width, @height = case content_type
        when :swf  then SWF.dimensions(stream)
        when :jpeg then JPEG.dimensions(stream)
        when :gif  then GIF.dimensions(stream)
        when :png  then PNG.dimensions(stream)
      end
    end

    private

    def content_type(file)
      case File.extname(file.path)
        when '.swf'      then :swf
        when /^\.jpe?g$/ then :jpeg
        when '.gif'      then :gif
        when '.png'      then :png
        else raise "Unsupported file type. Sorry bub :("
      end
    end

    def get_stream(file)
      if file.is_a?(String)
        File.new(file, 'rb')
      elsif file.is_a?(IO)
        file
      else
        raise 'Unable to read source file'
      end
    end

  end

end
