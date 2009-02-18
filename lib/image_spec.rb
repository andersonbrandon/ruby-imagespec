require 'open-uri'
Dir[File.join(File.dirname(__FILE__), 'parsers/*')].each { |f| require f }

class ImageSpec

  attr_reader :filename, :stream, :content_type
  attr_reader :width, :height

  def initialize(file)
    @stream = stream_for(file)
    @filename = @stream.path || file
    @content_type ||= content_type_from_filename(@filename)

    @width, @height = case @content_type
    when 'image/gif'
      Parsers::GIF.dimensions(@stream)
    when 'image/jpeg'
      Parsers::JPEG.dimensions(@stream)
    when 'image/png'
      Parsers::PNG.dimensions(@stream)
    when 'application/x-shockwave-flash'
      Parsers::SWF.dimensions(@stream)
    end
  end

  private

  def content_type_from_filename(filename)
    case File.extname(filename)
      when '.gif'      then 'image/gif'
      when /^\.jpe?g$/ then 'image/jpeg'
      when '.png'      then 'image/png'
      when '.swf'      then 'application/x-shockwave-flash'
      else raise "#{File.extname(filename)} is not supported. Sorry bub :("
    end
  end

  def stream_for(file)
    if file.respond_to?(:read)
      file
    elsif file.is_a?(String)
      stream = open(file)
      @content_type = stream.content_type if stream.respond_to?(:content_type)
      stream
    else
      raise "Unable to read #{file}"
    end
  end

end
