#!/usr/bin/env ruby
require "pathname"

# Automates searching through a directory exported by 
# Xcode.
# 
# ruby all.rb path/to/exported/directory

directory = File.expand_path(ARGV[0])
puts "Searching directory #{directory}…"

languages = Pathname.new(directory).children.select { |c| c.directory? }

languages.each do |language|
	content_directory = Pathname.new(language + "Localized Contents/")
	xliff = content_directory.children.select { |c| !c.directory? }.first
	puts "Found #{xliff.to_s}"

	system('ruby', 'xliff2csv.rb', '-S', xliff.to_s)
end