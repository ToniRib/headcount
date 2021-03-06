require_relative 'data_formattable'

class RangeCurrencyParser
  include DataFormattable

  def parse(ruby_rows)
    data = {}

    ruby_rows.each do |csv_row|
      row_data = convert_to_float(csv_row.row_data[:data])

      data[location(csv_row)] ||= {}
      data[location(csv_row)][year_range(csv_row)] = row_data
    end

    data
  end

  def location(csv_row)
    csv_row.row_data[:location]
  end

  def year_range(csv_row)
    csv_row.row_data[:timeframe].split('-').map(&:to_i)
  end
end
