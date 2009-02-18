Dir[File.join(File.dirname(__FILE__), 'parsers/*')].each { |f| require f }

class ImageSpec

  CONTENT_TYPES = {
    'image/gif'  => :gif,
    'image/jpeg' => :jpeg,
    'image/png'  => :png,
    'application/x-shockwave-flash' => :swf
  }

  attr_reader :filename, :stream, :content_type
  attr_reader :width, :height

  def initialize(file)
    @stream = stream_for(file)
    @filename = @stream.path || file
    @content_type ||= content_type_from_filename(@filename)

    @width, @height = case CONTENT_TYPES[@content_type]
      when :gif  then Parsers::GIF.dimensions(@stream)
      when :jpeg then Parsers::JPEG.dimensions(@stream)
      when :png  then Parsers::PNG.dimensions(@stream)
      when :swf  then Parsers::SWF.dimensions(@stream)
    end
  end

  private

  def content_type_from_filename(filename)
    case File.extname(filename)
      when '.gif'      then 'image/gif'
      when /^\.jpe?g$/ then 'image/jpeg'
      when '.png'      then 'image/png'
      when '.swf'      then 'application/x-shockwave-flash'
      else raise "Unsupported file type. Sorry bub :("
    end
  end

  def stream_for(file)
    if file.respond_to?(:read)
      file
    elsif file.is_a?(String)
      begin
        File.new(file, 'rb')
      rescue
        require 'net/http'
        require 'uri'
        response = Net::HTTP.get_response(URI.parse(file))
        @content_type = response.header['content-type']
        StringIO.new(response.body)
      end
    else
      raise 'Unable to read source file'
    end
  end

end
