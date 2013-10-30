libdir = File.expand_path(File.join(__dir__, '../lib'))
$LOAD_PATH.push(libdir) if libdir && !$LOAD_PATH.include?(libdir)
