require 'open-uri'
Dir[File.join(File.dirname(__FILE__), 'parser/*.rb')].each { |f| require f }

class ImageSpec

  attr_reader :width, :height

  def initialize(file)
    stream   = stream_for(file)
    filename = stream.path || file

    @width, @height = case
    when Parser::GIF.gif?(stream)
      Parser::GIF.dimensions(stream)
    when Parser::JPEG.jpeg?(stream)
      Parser::JPEG.dimensions(stream)
    when Parser::PNG.png?(stream)
      Parser::PNG.dimensions(stream)
    when Parser::SWF.swf?(stream)
      Parser::SWF.dimensions(stream)
    else
      raise "#{File.basename(filename)} is not supported. Sorry bub :("
    end
  end

  private

  def stream_for(file)
    if file.respond_to?(:read)
      file
    elsif file.is_a?(String)
      open(file, 'rb')
    else
      raise "Unable to read #{file}"
    end
  end

end
