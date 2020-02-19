class ParseJournals
  require './journal_csv_row'
  require 'csv'

  def initialize(journals_filename)
    @journals_filename = journals_filename
  end

  def call
    if all_rows_valid?
      rows.map(&:normalised_row).to_h
    else
      false
    end
  end

  private

  attr_reader :journals_filename

  def csv_string
    @csv_string ||= File.read(journals_filename)
  end

  def rows
    @rows ||= construct_rows
  end

  def construct_rows
    CSV.parse(csv_string, headers: true, header_converters: :symbol).map do |row|
      JournalCsvRow.new(row)
    end
  end

  def all_rows_valid?
    @all_rows_valid ||= invalid_rows.empty?
  end

  def invalid_rows
    @invalid_rows ||= rows.reject(&:valid?)
  end
end
