class ImageSpec

  class JPEG

    def self.dimensions(io)
       raise 'malformed JPEG' unless io.getc == 0xFF && io.getc == 0xD8 # SOI

       class << io
         def readint; (readchar << 8) + readchar; end
         def readframe; read(readint - 2); end
         def readsof; [readint, readchar, readint, readint, readchar]; end
         def next
           c = readchar while c != 0xFF
           c = readchar while c == 0xFF
           c
         end
       end

       while marker = io.next
         case marker
         when 0xC0..0xC3, 0xC5..0xC7, 0xC9..0xCB, 0xCD..0xCF
           length, bits, height, width, components = io.readsof
           raise 'malformed JPEG' unless length == 8 + components * 3
           return [width, height]
         when 0xD9, 0xDA:
           break
         when 0xFE:
           @comment = io.readframe
         when 0xE1:
           io.readframe
         else
           io.readframe
         end
       end
     end

  end

end
