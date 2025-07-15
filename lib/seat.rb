class Seat
    TYPE = { WINDOW: :window, AISLE: :aisle, MIDDLE: :middle }
  
    attr_reader :row, :col, :type, :block_idx, :passenger
  
    def initialize(row:, col:, block_idx:, type:)
      @row = row
      @col = col
      @block_idx = block_idx
      @type = type
      @passenger = nil
    end
  
    def can_be_assigned?(wanted_type)
      @passenger.nil? && @type == wanted_type
    end
  
    def assign(_, passenger_no, _)
      return false unless @passenger.nil?
      @passenger = passenger_no
      true
    end
  end
  