class Row
    attr_reader :index, :blocks
  
    def initialize(index, blocks)
      @index = index
      @blocks = blocks
    end
  end
  