require 'dohroot/findup'

module Doh
extend self

def root
  @root
end

def root=(directory)
  @root = directory
  libdir = File.join(@root, 'lib')
  $LOAD_PATH.push(libdir) if libdir && !$LOAD_PATH.include?(libdir)
end

def find_root(start_directory, filename = 'dohroot', max_tries = 20)
  rootfile = Doh.findup(start_directory, filename, max_tries)
  if rootfile
    Doh.root = File.dirname(rootfile)
  end
end

def find_root_from_file(filepath = nil)
  Doh.find_root(File.dirname(filepath || caller[0]))
end

def find_root_from_path(path)
  if File.directory?(path)
    Doh.find_root(path)
  else
    Doh.find_root(File.dirname(path))
  end
end

def find_root_from_prog
  Doh.find_root(File.dirname($PROGRAM_NAME))
end

def find_root_from_pwd
  Doh.find_root(Dir.pwd)
end

end
