class ArticleCsvRow
  require './helpers'
  attr_reader :csv_row

  def initialize(csv_row)
    @csv_row = csv_row
  end

  def valid?
    !csv_row.fetch(:title).empty? && !csv_row.fetch(:issn).empty? && !csv_row.fetch(:doi).empty?
  end

  def normalised_row
    @normalised_row ||= { issn: Helpers::normalise_issn(csv_row[:issn]), doi: csv_row[:doi], title: csv_row[:title] }
  end
end
