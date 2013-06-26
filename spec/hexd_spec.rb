require 'spec_helper'
require 'hexd'
require 'stringio'

describe Hexd::Dump do
  let(:input) do
    StringIO.new.tap do |io|
      io.write(msg)
      io.rewind
    end
  end
  
  let(:msg) { 'helloworldfoobar' }
  
  let(:subject) { Hexd::Dump.new(input) }
  
  it 'dumps the correct hex for a simple message' do
    line = subject.first
    
    offset_col, byte_col_one, byte_col_two, ascii_col = line.split('  ')
    offset_col.must_equal   '00000000'
    byte_col_one.must_equal '68 65 6c 6c 6f 77 6f 72'
    byte_col_two.must_equal '6c 64 66 6f 6f 62 61 72'
    ascii_col.must_equal    '|helloworldfoobar|'
  end
end
