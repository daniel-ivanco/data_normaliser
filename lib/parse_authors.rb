class ParseAuthors
  require './author_json_row'
  require 'json'

  def initialize(authors_filename)
    @authors_filename = authors_filename
  end

  def call
    if all_rows_valid?
      rows.map(&:normalised_row).reduce(:+).to_h
    else
      false
    end
  end

  private

  attr_reader :authors_filename

  def json_string
    @json_string ||= File.read(authors_filename)
  end

  def rows
    @rows ||= construct_rows
  end

  def construct_rows
    JSON.parse(json_string, symbolize_names: true).map do |row|
      AuthorJsonRow.new(row)
    end
  end

  def all_rows_valid?
    @all_rows_valid ||= invalid_rows.empty?
  end

  def invalid_rows
    @invalid_rows ||= rows.reject(&:valid?)
  end
end
