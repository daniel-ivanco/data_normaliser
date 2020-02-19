class JournalCsvRow
  require './helpers'
  attr_reader :csv_row

  def initialize(csv_row)
    @csv_row = csv_row
  end

  def valid?
    !csv_row.fetch(:title).empty? && !csv_row.fetch(:issn).empty?
  end

  def normalised_row
    @normalised_row ||= [ Helpers::normalise_issn(csv_row[:issn]), csv_row[:title] ]
  end
end
