#!/usr/bin/env ruby

require 'csv'
require 'json'
require 'yaml'

ROWS = CSV.parse(
  File.read('iller_ve_ilceler.csv'),
  headers: true,
  header_converters: :symbol
)

def nested_hash
  hash = {}
  ROWS.each do |row|
    key = row[:il_kodu]
    hash[key] = { ilceler: [] } unless hash.key? key
    hash[key][:ad] = row[:il_adi]
    hash[key][:kod] = row[:il_kodu]
    hash[key][:ilceler] << { ad: row[:ilce_adi], kod: row[:ilce_kodu] }
  end
  hash
end

def csv_to_json
  File.open('iller_ve_ilceler.json', 'w') do |f|
    f.puts nested_hash.to_json
  end
end

def csv_to_yaml
  File.open('iller_ve_ilceler.yml', 'w') do |f|
    f.puts nested_hash.to_yaml
  end
end

def main
  csv_to_json
  csv_to_yaml
end

main if $PROGRAM_NAME == __FILE__
