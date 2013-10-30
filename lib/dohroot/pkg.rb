require 'dohroot/main'

module Doh
extend self

def use_pkg(init_file, *name_list)
  if name_list.empty?
    Dir.glob(File.join(Doh.root, 'pkg/*/')).each do |rootdir|
      name_list << File.basename(rootdir)
    end
  end

  @pkg_used ||= []
  retval = false
  name_list.each do |name|
    next if @pkg_used.include?(name)
    retval = true
    @pkg_used << name
    use_one_pkg(init_file, name)
  end
  retval
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

end
