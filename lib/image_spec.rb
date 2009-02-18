require 'open-uri'
Dir[File.join(File.dirname(__FILE__), 'parsers/*')].each { |f| require f }

class ImageSpec

  attr_reader :width, :height

  def initialize(file)
    stream   = stream_for(file)
    filename = stream.path || file

    @width, @height = case
    when Parsers::GIF.gif?(stream)
      Parsers::GIF.dimensions(stream)
    when Parsers::JPEG.jpeg?(stream)
      Parsers::JPEG.dimensions(stream)
    when Parsers::PNG.png?(stream)
      Parsers::PNG.dimensions(stream)
    when Parsers::SWF.swf?(stream)
      Parsers::SWF.dimensions(stream)
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
