require './source_combinator'

if ARGV.length < 4
  puts "Too few arguments"
  exit
end

format = [ARGV[0..1]].to_h['--format']
if format.empty?
  puts "Wrong format"
  exit
end

if format == 'csv'
  puts ::SourceCombinator.new(ARGV[2], ARGV[3], ARGV[4]).generate_csv
else
  puts ::SourceCombinator.new(ARGV[2], ARGV[3], ARGV[4]).generate_json
end