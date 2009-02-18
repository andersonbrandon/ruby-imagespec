class ImageSpec

  module Parsers

    class GIF

      def self.dimensions(file)
        file.seek(6)
        file.read(4).unpack('SS')
      end

    end

  end

end
