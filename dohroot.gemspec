require 'rake'

Gem::Specification.new do |s|
  s.name = 'dohroot'
  s.version = '0.1.8'
  s.summary = 'tiniest root of doh stuff'
  s.description = "Implements the notion of dohroot that enables most other doh stuff."
  s.require_path = 'lib'
  s.required_ruby_version = '>= 2.2.0'
  s.authors = ['Makani Mason', 'Kem Mason']
  s.homepage = 'https://github.com/atpsoft/dohroot'
  s.license = 'MIT'
  s.email = ['devinfo@atpsoft.com']
  s.extra_rdoc_files = ['MIT-LICENSE']
  s.test_files = FileList["{test}/**/*.rb"].to_a
  s.files = FileList["{lib,test}/**/*"].to_a
end
