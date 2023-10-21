#!/usr/bin/env ruby

require 'fileutils'
require 'json'
require "debug"

def run(input_path, base, merge_json_path, output, processed_path)
  FileUtils.mkdir_p(processed_path)
  FileUtils.mkdir_p(input_path)

  puts "Consuming files in #{input_path} path"

  files = Dir.open(input_path) do |input_dir|
    FileUtils.touch File.join(Dir.pwd, input_dir, '.gitkeep')

    Dir.glob(File.join(Dir.pwd, input_dir, '*.json'))
  end

  puts "Merging files to #{output}, using #{base} as base"

  base = JSON.load_file!(base)
  base_dest = base.dig(*merge_json_path.split("."))

  files.each do |input_path|
    json = JSON.load_file!(input_path)

    base_dest.append(json)
  end

  output_json = JSON.pretty_generate(base)

  puts "Writing to #{output}:"
  puts output_json
  puts '<EOF>'

  File.open(output, 'w') do |f|
    f.write(output_json)
  end

  # Move files to processed_path folder
  FileUtils.mv files, processed_path, verbose: true
end

run(*ARGV)
