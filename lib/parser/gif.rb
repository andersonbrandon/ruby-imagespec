class ImageSpec

  module Parser

    class GIF

      CONTENT_TYPE = 'image/gif'

      def self.attributes(stream)
        width, height = dimensions(stream)
        {:width => width, :height => height, :content_type => CONTENT_TYPE}
      end

      def self.detected?(stream)
        stream.rewind
        stream.read(4) == 'GIF8'
      end

      def self.dimensions(stream)
        stream.seek(6)
        stream.read(4).unpack('SS')
      end

    end

  end

end
