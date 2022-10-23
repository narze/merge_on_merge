#!/usr/bin/env ruby

require 'fileutils'

def run(input_path, base, output, processed_path)
  FileUtils.mkdir_p(processed_path)
  FileUtils.mkdir_p(input_path)

  puts "Consuming files in #{input_path} path"

  files = Dir.open(input_path) do |input_dir|
    FileUtils.touch File.join(Dir.pwd, input_dir, '.gitkeep')

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

  # Move files to processed_path folder
  FileUtils.mv files, processed_path, verbose: true
end

run(*ARGV)
