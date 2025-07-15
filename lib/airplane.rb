require_relative './block'
require_relative './row'

class Airplane
  attr_reader :rows, :blocks

  def self.create(layout)
    new(layout)
  end

  def initialize(layout)
    @blocks = layout.each_with_index.map do |(cols, rows), i|
      Block.new(cols, rows, index: i, total_blocks: layout.length)
    end
    build_rows
  end

  def assign_passengers(count)
    passenger_no = 1
    %i[aisle window middle].each do |type|
      (0...@rows.length).each do |r_index|
        @rows[r_index].blocks.each do |blk|
          blk.seats_in_row(r_index).each do |seat|
            next unless seat.can_be_assigned?(Seat::TYPE[type.upcase.to_sym])
            puts "Assigning passenger #{passenger_no} to seat at row #{seat.row} col #{seat.col} (type: #{seat.type})"

            seat.assign(type, passenger_no, passenger_no)
            passenger_no += 1
            return if passenger_no > count
          end
        end
      end
    end
  end
  

  private

  def build_rows
    max_rows = @blocks.map(&:rows).max
    @rows = (0...max_rows).map do |r|
      Row.new(r, @blocks.select { |blk| blk.rows > r })
    end
  end

  def seats_by_type(type)
    @rows.flat_map do |row|
      row.blocks.flat_map { |blk| blk.seats_in_row(row.index) }
    end.select { |seat| seat.type == Seat::TYPE[type.upcase.to_sym] }
  end
end
