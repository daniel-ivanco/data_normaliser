class ParseArticles
  require './article_csv_row'
  require 'csv'

  def initialize(articles_filename)
    @articles_filename = articles_filename
  end

  def call
    if all_rows_valid?
      rows.map(&:normalised_row)
    else
      false
    end
  end

  private

  attr_reader :articles_filename

  def csv_string
    @csv_string ||= File.read(articles_filename)
  end

  def rows
    @rows ||= construct_rows
  end

  def construct_rows
    CSV.parse(csv_string, headers: true, header_converters: :symbol).map do |row|
      ArticleCsvRow.new(row)
    end
  end

  def all_rows_valid?
    @all_rows_valid ||= invalid_rows.empty?
  end

  def invalid_rows
    @invalid_rows ||= rows.reject(&:valid?)
  end
end
