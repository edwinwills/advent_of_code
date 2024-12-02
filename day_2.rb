input = File.read("day_2_data.txt")
rows = input.split("\n")
rows = rows.map { |row| row.split(" ") }
rows = rows.map { |row| row.map(&:to_i) }

def valid_asc?(entry, record)
  entry < record && (record <= (entry + 3))
end

def valid_desc?(entry, record)
  entry > record && (record >= (entry - 3))
end

def safe?(record)
  direction = record[0] < record[1] ? 'asc' : 'desc'
  entries = record.select.with_index do |entry, index|
    next true if index == (record.count - 1)

    next_record = [record[index + 1]]

    valid_records = if direction == 'asc'
                      next_record.select do |next_record|
                        true if valid_asc?(entry, next_record)
                      end
                    else
                      next_record.select do |next_record|
                        true if valid_desc?(entry, next_record)
                      end
                    end

    next true if valid_records.any?

    false
  end

  entries.count == record.count
end

# part 1
puts rows.select { |row| safe?(row) }.count

# part 2
puts rows.select do |row|
  (0..(row.count - 1)).to_a.select do |index|
    tmp_row = row
    safe?(tmp_row.reject.with_index {|v, i| i == index })
  end.any?
end.count
