$:.unshift File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'hexd'
  s.version     = '0.1.2'
  s.summary     = 'a simple hex dump tool'
  s.description = s.summary
  s.author      = 'John Doe'
  s.email       = 'arcsum42@gmail.com'
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/arcsum/hexd'
  s.bindir      = 'bin'
  s.files       = Dir['README.md', 'LICENSE.md', 'lib/**/*.rb', 'bin/**/*']
  s.executables << 'hexd'
end
