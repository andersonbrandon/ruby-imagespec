class ImageSpec

  module Parser

    class PNG

      CONTENT_TYPE = 'image/png'

      def self.attributes(stream)
        width, height = dimensions(stream)
        {:width => width, :height => height, :content_type => CONTENT_TYPE}
      end

      def self.detected?(stream)
        stream.rewind
        stream.read(4) == "\x89PNG"
      end

      def self.dimensions(stream)
        stream.seek(0x10)
        stream.read(8).unpack('NN')
      end

    end

  end

end
