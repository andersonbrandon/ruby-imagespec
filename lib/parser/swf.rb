require 'zlib'

class ImageSpec

  module Parser

    class SWF

      CONTENT_TYPE = 'application/x-shockwave-flash'

      def self.attributes(stream)
        width, height = dimensions(stream)
        {:width => width, :height => height, :content_type => CONTENT_TYPE}
      end

      def self.detected?(stream)
        stream.rewind
        stream.read(3) =~ /(F|C)WS/ ? true : false
      end

      def self.dimensions(stream)
        # Read the entire stream into memory because the
        # dimensions aren't stored in a standard location
        stream.rewind
        contents = stream.read

        # Our 'signature' is the first 3 bytes
        # Either FWS or CWS.  CWS indicates compression
        signature = contents[0..2]

        # Determine the length of the uncompressed stream
        length = contents[4..7].unpack('V').join.to_i

        # If we do, in fact, have compression
        if signature == 'CWS'
          # Decompress the body of the SWF
          body = Zlib::Inflate.inflate( contents[8..length] )

          # And reconstruct the stream contents to the first 8 bytes (header)
          # Plus our decompressed body
          contents = contents[0..7] + body
        end

        # Determine the nbits of our dimensions rectangle
        nbits = contents[8] >> 3

        # Determine how many bits long this entire RECT structure is
        rectbits = 5 + nbits * 4    # 5 bits for nbits, as well as nbits * number of fields (4)

        # Determine how many bytes rectbits composes (ceil(rectbits/8))
        rectbytes = (rectbits.to_f / 8).ceil

        # Unpack the RECT structure from the stream in little-endian bit order, then join it into a string
        rect = contents[8..(8 + rectbytes)].unpack("#{'B8' * rectbytes}").join()

        # Read in nbits incremenets starting from 5
        dimensions = Array.new
        4.times do |n|
          s = 5 + (n * nbits)     # Calculate our start index
          e = s + (nbits - 1)     # Calculate our end index
          dimensions[n] = rect[s..e].to_i(2)    # Read that range (binary) and convert it to an integer
        end

        # The values we have here are in "twips"
        # 20 twips to a pixel (that's why SWFs are fuzzy sometimes!)
        width   = (dimensions[1] - dimensions[0]) / 20
        height  = (dimensions[3] - dimensions[2]) / 20

        # If you can't figure this one out, you probably shouldn't have read this far
        return [width, height]

      end

    end

  end

end
