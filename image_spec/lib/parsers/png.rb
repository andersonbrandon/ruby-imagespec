module ImageSpec

  class PNG
    
    def self.dimensions(file)
      IO.read(file, 8, 0x10).unpack('NN')
    end
  
  end
  
end