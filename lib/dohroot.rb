require 'dohroot/findup'

module Doh
extend self

class DohRootNotFoundException < Exception
end

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

def use_pkg(init_file, *name_list)
  if name_list.empty?
    Dir.glob(File.join(Doh.root, 'pkg/*/')).each do |rootdir|
      name_list << File.basename(rootdir)
    end
  end

  @pkg_used ||= []
  name_list.each do |name|
    next if @pkg_used.include?(name)
    @pkg_used << name
    use_one_pkg(init_file, name)
  end
end

private

def use_one_pkg(init_file, name)
  libdir = File.join(Doh.root, "pkg/#{name}/lib")
  unless $LOAD_PATH.include?(libdir)
    $LOAD_PATH << libdir
  end

  init_path = File.join(Doh.root, "pkg/#{name}/#{init_file}.rb")
  if File.exist?(init_path)
    require init_path
  end
end

end # module Doh
