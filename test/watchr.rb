watch('test/.*_test.*') {|md| system "rake test"}
watch('test/*') {|md| system "rake test"}
watch('lib/*') {|md| system "rake test"}

