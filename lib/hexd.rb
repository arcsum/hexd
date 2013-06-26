module Hexd
  BASE      = 16
  BYTE_SIZE = 8
  
  class Dump
    include Enumerable
    
    BYTES_PER_LINE = 16
    
    def initialize(input)
      @input = input
    end
    
    def each
      addr = 0
      while (line = @input.read(BYTES_PER_LINE))
        yield LineFormatter.new(addr, line).to_s
        addr += BYTES_PER_LINE
      end
      @input.rewind if @input.is_a?(File)
      nil
    end
    
    private
    
    class LineFormatter
      ASCII_COL_IDX = 60
      COL_SIZE      = 8
      
      def initialize(addr, line)
        @addr, @line = addr, line
      end
      
      def ascii_column
        AsciiFormatter.new(@line).to_s
      end
      
      def bytes_column_one
        @line.bytes[0...COL_SIZE].map do |b|
          ByteFormatter.new(b).to_s << ' '
        end.join
      end
      
      def bytes_column_two
        nbytes = @line.bytes.size
        
        if nbytes < COL_SIZE
          ''
        else
          @line.bytes[COL_SIZE...nbytes].map do |b|
            ByteFormatter.new(b).to_s << ' '
          end.join
        end
      end
      
      def offset_column
        OffsetFormatter.new(@addr).to_s
      end
      
      def to_s
        str = offset_column << '  ' << bytes_column_one << ' ' << bytes_column_two
        str = str.ljust(ASCII_COL_IDX) << ascii_column
      end
    end
    
    class OffsetFormatter
      def initialize(off)
        @off = off
      end
      
      def to_s
        @off.to_s(BASE).rjust(BYTE_SIZE, '0')
      end
    end
    
    class ByteFormatter
      def initialize(byte)
        @byte = byte
      end
      
      def to_s
        @byte.to_s(BASE).rjust(2, '0')
      end
    end
    
    class AsciiFormatter
      def initialize(ascii)
        @ascii = ascii
      end
      
      def printable_char?(c)
        c.ord >= ' '.ord && c.ord <= '~'.ord
      end
      
      def to_s
        str = '|'
        
        @ascii.each_char do |c|
          symbol = (printable_char?(c) ? c : '.')
          str << symbol
        end
        
        str << '|'
      end
    end
  end
end
