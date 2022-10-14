#!/usr/bin/env ruby

require 'fileutils'

def run(*_args)
  input = 'input'
  base = 'README.md'
  output = 'README.md'
  processed = 'processed'
  FileUtils.mkdir_p(processed)
  FileUtils.mkdir_p(input)

  puts "Consuming files in #{input} path"

  files = Dir.open(input) do |input_dir|
    Dir.glob(File.join(Dir.pwd, input_dir, '*'))
  end

  puts "Appending files to #{output}, using #{base} as base"

  input_lines = files.flat_map do |input_path|
    File.readlines(input_path, chomp: true)
  end

  base_lines = File.readlines(base, chomp: true)

  if (idx_to_append = base_lines.index { |l| l.start_with? '<!--%%% APPEND_ON_MERGE' })
    base_lines = [
      *base_lines[0...idx_to_append],
      *input_lines,
      *base_lines[idx_to_append..]
    ]
  else
    base_lines.concat(input_lines)
  end

  puts "Writing to #{output}:"
  puts base_lines
  puts '<EOF>'

  File.open(output, 'w') do |f|
    f.write(base_lines.join("\n"))
  end

  # Move files to processed folder
  FileUtils.mv files, processed, verbose: true
end

run(ARGV)
