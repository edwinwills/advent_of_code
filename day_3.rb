input = File.read("day_3_data.txt")

# part 1

multiplications = input.scan(/mul\(\d+,\d+\)/)
multiplications.map do |row|
  row = row.split(',').map do |number|
    number.match(/\d+/).to_s.to_i
  end
  row[0] * row[1]
end.sum

# part 2

multiplications = input.scan(/(mul\(\d+,\d+\))|(do\(\))|(don\'t\(\))/).flatten.compact
multiplying_enabled = true
multiplications.map do |row|
  if row == "do()"
    multiplying_enabled = true
  elsif row == "don't()"
    multiplying_enabled = false
  end

  if multiplying_enabled and row.match?(/mul/)
    row = row.split(',').map do |number|
      number.match(/\d+/).to_s.to_i
    end
    row[0] * row[1]
  else
    0
  end
end.sum
