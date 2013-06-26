# hexd

a simple hex dump tool

## usage

as an executable:

    hexd README.md
    cat README.md | hexd

as a library:

``` ruby
require 'hexd'

File.open('README.md') do |file|
  Hexd::Dump.new(file).each do |line|
    puts line
  end
end
```
